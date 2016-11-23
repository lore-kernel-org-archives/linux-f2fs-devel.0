From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: linux-next: Tree for Nov 23 (f2fs)
Date: Wed, 23 Nov 2016 10:11:22 -0800
Message-ID: <20161123181122.GA24137@jaegeuk>
References: <20161123175848.5b56c35c@canb.auug.org.au>
 <320e8cf0-a0ee-8178-9aec-b8c0002ceb6d@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-next-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <320e8cf0-a0ee-8178-9aec-b8c0002ceb6d@infradead.org>
Sender: linux-next-owner@vger.kernel.org
To: Randy Dunlap <rdunlap@infradead.org>
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hello,

On Wed, Nov 23, 2016 at 08:00:57AM -0800, Randy Dunlap wrote:
> On 11/22/16 22:58, Stephen Rothwell wrote:
> > Hi all,
> > 
> > Changes since 20161122:
> > 
> 
> on i386:
> 
> fs/built-in.o: In function `__issue_discard_async':
> segment.c:(.text+0x5e2135): undefined reference to `__umoddi3'
> 
> or when built as a loadable module:
> ERROR: "__umoddi3" [fs/f2fs/f2fs.ko] undefined!

It seems Arnd's patch deals with this.
I'll keep an eye on this.

Thanks,

> 
> 
> -- 
> ~Randy
