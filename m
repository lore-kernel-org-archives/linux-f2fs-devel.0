From: Chao Yu <chao2.yu@samsung.com>
Subject: RE: [PATCH RFC] f2fs: add fast symlink
Date: Thu, 12 Mar 2015 17:02:47 +0800
Message-ID: <000701d05ca3$77a597b0$66f0c710$@samsung.com>
References: <1426074741-31296-1-git-send-email-wanpeng.li@linux.intel.com>
 <009d01d05c7b$950dd970$bf298c50$@samsung.com> <20150312064210.GA12364@kernel>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-reply-to: <20150312064210.GA12364@kernel>
Content-language: zh-cn
Sender: linux-kernel-owner@vger.kernel.org
To: 'Wanpeng Li' <wanpeng.li@linux.intel.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Wanpeng,

> -----Original Message-----
> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
> Sent: Thursday, March 12, 2015 2:42 PM
> To: Chao Yu
> Cc: 'Wanpeng Li'; 'Jaegeuk Kim'; 'Changman Lee'; linux-f2fs-devel@lists.sourceforge.net;
> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
> Subject: Re: [PATCH RFC] f2fs: add fast symlink
> 
> Hi Chao,
> On Thu, Mar 12, 2015 at 12:17:29PM +0800, Chao Yu wrote:
> >
> >We always remain space in inode page for inline xattr data,
> >so it's better to define our max size of fast symlink as below:
> >
> >#define MAX_FAST_SYMLINK_SIZE	(MAX_INLINE_DATA + 1)
> >
> 
> Thanks for your review, I just handle all your comments and it works
> well.
> 
> Btw, one question, if inline xattr data area is reserved in inode
> even if it isn't mounted w/ inline_xattr option? If yes, why it
> is reserved?

It's not, it keeps space in inode page only if inode is created when
inline_xattr option is set. What I comment and suggest for
MAX_FAST_SYMLINK_SIZE is wrong, sorry about that.

We'd better set max size of fast symlink according to inline_xattr flag:

static inline unsigned int max_fast_symlink_size(struct inode *inode)
{
	return sizeof(__le32) * addrs_per_inode(F2FS_I(inode));
}

How do you think?

Thanks,

> 
> Regards,
> Wanpeng Li
