From: Joe Perches <joe@perches.com>
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: ratelimit recovery messages
Date: Tue, 28 May 2019 04:05:24 -0700
Message-ID: <6cc73c5454785faec229c8b78e63170e021a7c0d.camel@perches.com>
References: <1558962655-25994-1-git-send-email-stummala@codeaurora.org>
         <94025a6d-f485-3811-5521-ed5c9b4d1d77@huawei.com>
         <20190528030509.GE10043@codeaurora.org>
         <2575bd54-d67c-6b26-ebf7-d6adb2e193a7@huawei.com>
         <b5665201-d13d-5fcb-100d-21630960e5f1@huawei.com>
         <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <0341eb2c-6788-1c85-2036-ed57b7f99dab@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <yuchao0@huawei.com>, Gao Xiang <gaoxiang25@huawei.com>, Sahitya Tummala <stummala@codeaurora.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, 2019-05-28 at 15:37 +0800, Chao Yu wrote:
[]
> > > > > > diff --git a/fs/f2fs/recovery.c b/fs/f2fs/recovery.c
[]
> > > > > > @@ -188,8 +188,8 @@ static int recover_dentry(struct inode *inode, struct page *ipage,
> > > > > >  		name = "<encrypted>";
> > > > > >  	else
> > > > > >  		name = raw_inode->i_name;
> > > > > > -	f2fs_msg(inode->i_sb, KERN_NOTICE,
> > > > > > -			"%s: ino = %x, name = %s, dir = %lx, err = %d",
> > > > > > +	printk_ratelimited(KERN_NOTICE
> > > > > > +			"%s: ino = %x, name = %s, dir = %lx, err = %d\n",
> > > > > >  			__func__, ino_of_node(ipage), name,
> > > > > >  			IS_ERR(dir) ? 0 : dir->i_ino, err);

Probably better to add and use a f2fs_msg_ratelimited macro.

And the generic f2fs_msg should add printf
format and argument verification.
---
 fs/f2fs/f2fs.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 9b3d9977cd1e..2373bc3cb267 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1798,6 +1798,7 @@ static inline int inc_valid_block_count(struct f2fs_sb_info *sbi,
 	return -ENOSPC;
 }
 
+__printf(3, 4)
 void f2fs_msg(struct super_block *sb, const char *level, const char *fmt, ...);
 static inline void dec_valid_block_count(struct f2fs_sb_info *sbi,
 						struct inode *inode,
