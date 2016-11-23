From: Randy Dunlap <rdunlap@infradead.org>
Subject: Re: linux-next: Tree for Nov 23 (f2fs)
Date: Wed, 23 Nov 2016 08:00:57 -0800
Message-ID: <320e8cf0-a0ee-8178-9aec-b8c0002ceb6d@infradead.org>
References: <20161123175848.5b56c35c@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20161123175848.5b56c35c@canb.auug.org.au>
Sender: linux-kernel-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>, linux-next@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 11/22/16 22:58, Stephen Rothwell wrote:
> Hi all,
> 
> Changes since 20161122:
> 

on i386:

fs/built-in.o: In function `__issue_discard_async':
segment.c:(.text+0x5e2135): undefined reference to `__umoddi3'

or when built as a loadable module:
ERROR: "__umoddi3" [fs/f2fs/f2fs.ko] undefined!


-- 
~Randy
