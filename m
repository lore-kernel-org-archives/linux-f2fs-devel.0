From: Wanpeng Li <wanpeng.li@linux.intel.com>
Subject: Re: [PATCH RFC] f2fs: add fast symlink
Date: Thu, 12 Mar 2015 14:42:10 +0800
Message-ID: <20150312064210.GA12364@kernel>
References: <1426074741-31296-1-git-send-email-wanpeng.li@linux.intel.com>
 <009d01d05c7b$950dd970$bf298c50$@samsung.com>
Reply-To: Wanpeng Li <wanpeng.li@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <009d01d05c7b$950dd970$bf298c50$@samsung.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Chao Yu <chao2.yu@samsung.com>
Cc: 'Wanpeng Li' <wanpeng.li@linux.intel.com>, 'Jaegeuk Kim' <jaegeuk@kernel.org>, 'Changman Lee' <cm224.lee@samsung.com>, linux-f2fs-devel@lists.sourceforge.net, linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Chao,
On Thu, Mar 12, 2015 at 12:17:29PM +0800, Chao Yu wrote:
>
>We always remain space in inode page for inline xattr data,
>so it's better to define our max size of fast symlink as below:
>
>#define MAX_FAST_SYMLINK_SIZE	(MAX_INLINE_DATA + 1)
>

Thanks for your review, I just handle all your comments and it works
well. 

Btw, one question, if inline xattr data area is reserved in inode 
even if it isn't mounted w/ inline_xattr option? If yes, why it 
is reserved?

Regards,
Wanpeng Li 
