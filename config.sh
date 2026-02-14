#!/bin/bash

# 开发环境配置部署脚本
# 用法: ./config.sh

set -e

echo "=========================================="
echo "  开发环境配置部署脚本"
echo "=========================================="

# 颜色定义
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# 日志函数
info() { echo -e "${GREEN}[INFO]${NC} $1"; }
warn() { echo -e "${YELLOW}[WARN]${NC} $1"; }
error() { echo -e "${RED}[ERROR]${NC} $1"; exit 1; }

# 获取脚本所在目录
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# ===== 1. 检测操作系统 =====
detect_os() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        OS="macos"
    elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
        OS="linux"
    else
        error "不支持的操作系统: $OSTYPE"
    fi
    info "检测到操作系统: $OS"
}

# ===== 2. 安装依赖 =====
install_dependencies() {
    info "安装依赖..."

    if [[ "$OS" == "macos" ]]; then
        # 检查 Homebrew
        if ! command -v brew &> /dev/null; then
            warn "Homebrew 未安装，正在安装..."
            /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
        fi

        # 安装必要工具
        info "通过 Homebrew 安装工具..."
        brew install neovim fzf ripgrep fd bat git || true

    elif [[ "$OS" == "linux" ]]; then
        # 检测包管理器
        if command -v apt-get &> /dev/null; then
            sudo apt-get update
            sudo apt-get install -y neovim fzf ripgrep fd-find bat git curl
        elif command -v yum &> /dev/null; then
            sudo yum install -y neovim fzf ripgrep fd-find bat git curl
        elif command -v pacman &> /dev/null; then
            sudo pacman -S --noconfirm neovim fzf ripgrep fd bat git curl
        else
            warn "未检测到支持的包管理器，请手动安装依赖"
        fi
    fi
}

# ===== 3. 备份现有配置 =====
backup_configs() {
    info "备份现有配置..."
    BACKUP_DIR="$HOME/.config_backup_$(date +%Y%m%d_%H%M%S)"
    mkdir -p "$BACKUP_DIR"

    # 备份文件列表
    files_to_backup=(
        "$HOME/.vimrc"
        "$HOME/.vim"
        "$HOME/.bashrc"
        "$HOME/.zshrc"
        "$HOME/.tmux.conf"
        "$HOME/.gitconfig"
        "$HOME/.config/nvim"
    )

    for file in "${files_to_backup[@]}"; do
        if [[ -e "$file" ]]; then
            cp -r "$file" "$BACKUP_DIR/" 2>/dev/null || true
            info "已备份: $file"
        fi
    done

    info "备份完成: $BACKUP_DIR"
}

# ===== 4. 部署 Shell 配置 =====
deploy_shell_configs() {
    info "部署 Shell 配置..."

    # 部署 bashrc
    cp "$SCRIPT_DIR/.bashrc" "$HOME/.bashrc"
    info "已部署: .bashrc"

    # 部署 zshrc
    cp "$SCRIPT_DIR/.zshrc" "$HOME/.zshrc"
    info "已部署: .zshrc"

    # 部署 git-completion
    if [[ -f "$SCRIPT_DIR/.git-completion.bash" ]]; then
        cp "$SCRIPT_DIR/.git-completion.bash" "$HOME/.git-completion.bash"
        info "已部署: .git-completion.bash"
    fi

    # 安装 zsh 插件 (如果使用 oh-my-zsh)
    if [[ -d "$HOME/.oh-my-zsh" ]]; then
        ZSH_CUSTOM="${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}"

        # zsh-autosuggestions
        if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-autosuggestions" ]]; then
            info "安装 zsh-autosuggestions..."
            git clone https://github.com/zsh-users/zsh-autosuggestions "$ZSH_CUSTOM/plugins/zsh-autosuggestions" || true
        fi

        # zsh-syntax-highlighting
        if [[ ! -d "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" ]]; then
            info "安装 zsh-syntax-highlighting..."
            git clone https://github.com/zsh-users/zsh-syntax-highlighting "$ZSH_CUSTOM/plugins/zsh-syntax-highlighting" || true
        fi
    fi
}

# ===== 5. 部署 Neovim 配置 =====
deploy_nvim_config() {
    info "部署 Neovim 配置..."

    # 创建配置目录
    mkdir -p "$HOME/.config/nvim"

    # 复制配置
    cp -r "$SCRIPT_DIR/.config/nvim/"* "$HOME/.config/nvim/"
    info "已部署: Neovim 配置"

    # 首次启动 Neovim 安装插件
    info "首次启动 Neovim 安装插件 (这可能需要一些时间)..."
    nvim --headless "+Lazy! sync" +qa 2>/dev/null || true
}

# ===== 6. 部署 Tmux 配置 =====
deploy_tmux_config() {
    info "部署 Tmux 配置..."

    # 部署配置文件
    cp "$SCRIPT_DIR/.tmux.conf" "$HOME/.tmux.conf"
    info "已部署: .tmux.conf"

    # 安装 TPM
    if [[ ! -d "$HOME/.tmux/plugins/tpm" ]]; then
        info "安装 TPM (Tmux Plugin Manager)..."
        git clone https://github.com/tmux-plugins/tpm "$HOME/.tmux/plugins/tpm"
    fi

    # 安装 Tmux 插件
    info "安装 Tmux 插件..."
    "$HOME/.tmux/plugins/tpm/bin/install_plugins" 2>/dev/null || true
}

# ===== 7. 部署 Git 配置 =====
deploy_git_config() {
    info "部署 Git 配置..."

    # 部署 gitconfig
    cp "$SCRIPT_DIR/.gitconfig" "$HOME/.gitconfig"
    info "已部署: .gitconfig"

    # 部署全局 gitignore
    cp "$SCRIPT_DIR/.gitignore_global" "$HOME/.gitignore_global"
    info "已部署: .gitignore_global"

    # 提示设置用户信息
    warn "请记得设置 Git 用户信息:"
    echo "  git config --global user.name \"Your Name\""
    echo "  git config --global user.email \"your.email@example.com\""
}

# ===== 8. 安装 fzf =====
install_fzf() {
    if [[ ! -d "$HOME/.fzf" ]]; then
        info "安装 fzf..."
        git clone --depth 1 https://github.com/junegunn/fzf.git "$HOME/.fzf"
        "$HOME/.fzf/install" --all --no-bash --no-zsh --no-fish 2>/dev/null || true
    fi
}

# ===== 主函数 =====
main() {
    detect_os

    echo ""
    read -p "是否继续部署? (y/n) " -n 1 -r
    echo ""
    if [[ ! $REPLY =~ ^[Yy]$ ]]; then
        info "已取消"
        exit 0
    fi

    backup_configs
    install_dependencies
    deploy_shell_configs
    deploy_nvim_config
    deploy_tmux_config
    deploy_git_config
    install_fzf

    echo ""
    echo "=========================================="
    echo -e "${GREEN}  部署完成!${NC}"
    echo "=========================================="
    echo ""
    echo "后续步骤:"
    echo "  1. 重新打开终端或运行: source ~/.bashrc (或 ~/.zshrc)"
    echo "  2. 启动 nvim，插件会自动安装"
    echo "  3. 启动 tmux，按 prefix + I 安装插件"
    echo "  4. 设置 Git 用户信息"
    echo ""
}

# 运行主函数
main "$@"
