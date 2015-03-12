From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH RFC] f2fs: add fast symlink
Date: Thu, 12 Mar 2015 16:49:38 +0800
Message-ID: <20150312084938.GA2855@kernel>
References: <1426074741-31296-1-git-send-email-wanpeng.li@linux.intel.com>
 <009d01d05c7b$950dd970$bf298c50$@samsung.com>
 <20150312064210.GA12364@kernel>
 <000701d05ca3$77a597b0$66f0c710$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <000701d05ca3$77a597b0$66f0c710$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, Wanpeng Li <wanpeng.li@linux.intel.com>
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,
On Thu, Mar 12, 2015 at 05:02:47PM +0800, Chao Yu wrote:
>Hi Wanpeng,
>
>> -----Original Message-----
>> From: Wanpeng Li [mailto:wanpeng.li@linux.intel.com]
>> Sent: Thursday, March 12, 2015 2:42 PM
>> To: Chao Yu
>> Cc: 'Wanpeng Li'; 'Jaegeuk Kim'; 'Changman Lee'; linux-f2fs-devel@lists.sourceforge.net;
>> linux-fsdevel@vger.kernel.org; linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH RFC] f2fs: add fast symlink
>> 
>> Hi Chao,
>> On Thu, Mar 12, 2015 at 12:17:29PM +0800, Chao Yu wrote:
>> >
>> >We always remain space in inode page for inline xattr data,
>> >so it's better to define our max size of fast symlink as below:
>> >
>> >#define MAX_FAST_SYMLINK_SIZE	(MAX_INLINE_DATA + 1)
>> >
>> 
>> Thanks for your review, I just handle all your comments and it works
>> well.
>> 
>> Btw, one question, if inline xattr data area is reserved in inode
>> even if it isn't mounted w/ inline_xattr option? If yes, why it
>> is reserved?
>
>It's not, it keeps space in inode page only if inode is created when
>inline_xattr option is set. What I comment and suggest for
>MAX_FAST_SYMLINK_SIZE is wrong, sorry about that.
>
>We'd better set max size of fast symlink according to inline_xattr flag:
>
>static inline unsigned int max_fast_symlink_size(struct inode *inode)
>{
>	return sizeof(__le32) * addrs_per_inode(F2FS_I(inode));
>}
>

Cool, this one looks more reasonable to me. I will send a newer version
of patch.

Regards,
Wanpeng Li 

>How do you think?
>
>Thanks,
>
>> 
>> Regards,
>> Wanpeng Li
