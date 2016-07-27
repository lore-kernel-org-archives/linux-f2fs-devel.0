From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs for 4.8
Date: Wed, 27 Jul 2016 10:46:19 -0700
Message-ID: <CA+55aFwnNLqsuL_LwAV4OYQf9v+pje5w=OwoE=oA-R8QpXB-Cg@mail.gmail.com>
References: <20160727040800.GA69756@jaegeuk>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20160727040800.GA69756@jaegeuk>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>, Jens Axboe <axboe@fb.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Linux FS Dev Mailing List <linux-fsdevel@vger.kernel.org>, Linux F2FS Dev Mailing List <linux-f2fs-devel@lists.sourceforge.net>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Tue, Jul 26, 2016 at 9:08 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
>   git://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git tags/for-f2fs-4.8

This got some merge conflicts with the bio interface rework
(bio_set_op_attrs() etc), and while I tried to fix it up, I don't have
any sane way to test the end result, so I might have screwed up
royally.

My resolution looks sane to me, and compiles, but that's all I'm
really going to guarantee. Can you please give it a good round of
testing, and Jens, can you check it out too. In particular, the
fs/f2fs/data.c changes is what I might have screwed up..

                  Linus
