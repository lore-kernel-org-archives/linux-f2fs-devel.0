From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH v3 2/2] f2fs: enable fast symlink by utilizing inline data
Date: Tue, 24 Mar 2015 15:41:59 +0800
Message-ID: <20150324074159.GA2759@kernel>
References: <1427163628-3840-1-git-send-email-wanpeng.li@linux.intel.com>
 <1427163628-3840-2-git-send-email-wanpeng.li@linux.intel.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1427163628-3840-2-git-send-email-wanpeng.li@linux.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Changman Lee <cm224.lee@samsung.com>, Chao Yu <chao2.yu@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Ping this one.
On Tue, Mar 24, 2015 at 10:20:28AM +0800, Wanpeng Li wrote:
>Fast symlink can utilize inline data flow to avoid using any
>i_addr region, since we need to handle many cases such as
>truncation, roll-forward recovery, and fsck/dump tools.
>
>Signed-off-by: Wanpeng Li <wanpeng.li@linux.intel.com>
>---
> fs/f2fs/inline.c | 2 +-
> 1 file changed, 1 insertion(+), 1 deletion(-)
>
>diff --git a/fs/f2fs/inline.c b/fs/f2fs/inline.c
>index d3e0599..375d2c7 100644
>--- a/fs/f2fs/inline.c
>+++ b/fs/f2fs/inline.c
>@@ -21,7 +21,7 @@ bool f2fs_may_inline(struct inode *inode)
> 	if (f2fs_is_atomic_file(inode))
> 		return false;
> 
>-	if (!S_ISREG(inode->i_mode))
>+	if (!S_ISREG(inode->i_mode) && !S_ISLNK(inode->i_mode))
> 		return false;
> 
> 	if (i_size_read(inode) > MAX_INLINE_DATA)
>-- 
>2.1.0
