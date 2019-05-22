From: Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH v4 1/1] f2fs: ioctl for removing a range from F2FS
Date: Wed, 22 May 2019 08:09:58 -0700
Message-ID: <20190522150958.GC6738@bombadil.infradead.org>
References: <20190522040530.37886-1-sunqiuyang@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190522040530.37886-1-sunqiuyang@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: sunqiuyang <sunqiuyang@huawei.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net, yuchao0@huawei.com
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Wed, May 22, 2019 at 12:05:30PM +0800, sunqiuyang wrote:
> +static int f2fs_ioc_resize_fs(struct file *filp, unsigned long arg)
> +{
> +	struct f2fs_sb_info *sbi = F2FS_I_SB(file_inode(filp));
> +	__u64 block_count;
> +	int ret;
> +
> +	if (!capable(CAP_SYS_ADMIN))
> +		return -EPERM;
> +
> +	if (f2fs_readonly(sbi->sb))
> +		return -EROFS;
> +
> +	if (copy_from_user(&block_count, (__u64 __user *)arg, sizeof(__u64)))
> +		return -EFAULT;

You can just call get_user() here.
