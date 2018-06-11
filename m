From: Jaegeuk Kim <jaegeuk@kernel.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 10:51:03 -0700
Message-ID: <20180611175103.GA9244@jaegeuk-macbookpro.roam.corp.google.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
 <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Linus Torvalds <torvalds@linux-foundation.org>
Cc: Eric Biggers <ebiggers@google.com>, Chao Yu <yuchao0@huawei.com>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 06/11, Linus Torvalds wrote:
> On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> >
> > Eric Biggers (4):
> >       f2fs: call unlock_new_inode() before d_instantiate()
> 
> Btw, in my merge, this got superseded by commit 1e2e547a93a00ebc2158
> ("do d_instantiate/unlock_new_inode combinations safely"), because the
> ordering of that d_instantiate() and unlock_new_inode() was subtler
> than just doing the unlock first.
> 
> I can't test the end result, so you guys should double-check whatever
> xfstest you ran originall, ok?

https://lkml.org/lkml/2018/5/13/248
Got it. Thanks.

> 
>             Linus
