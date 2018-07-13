From: Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH] [RESEND] f2fs: use timespec64 for inode timestamps
Date: Fri, 13 Jul 2018 20:50:36 +0200
Message-ID: <CAK8P3a2St2AG5Vm2iwHHuaMuM-fkwjz2i-_oL6WR26FdGuEYkQ@mail.gmail.com>
References: <20180713143800.3146610-1-arnd@arndb.de> <20180713161006.GA40688@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180713161006.GA40688@jaegeuk-macbookpro.roam.corp.google.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: Chao Yu <yuchao0@huawei.com>, y2038 Mailman List <y2038@lists.linaro.org>, Sheng Yong <shengyong1@huawei.com>, Theodore Ts'o <tytso@mit.edu>, Eric Biggers <ebiggers@google.com>, Yunlei He <heyunlei@huawei.com>, Deepa Dinamani <deepa.kernel@gmail.com>, Yunlong Song <yunlong.song@huawei.com>, "Linux F2FS DEV, Mailing List" <linux-f2fs-devel@lists.sourceforge.net>, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
List-Id: linux-f2fs-devel.lists.sourceforge.net

On Fri, Jul 13, 2018 at 6:10 PM, Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Hi Arnd,
>
> I queued in the testing branch, since I'm trying to fix another issue in -next.
>
> https://git.kernel.org/pub/scm/linux/kernel/git/jaegeuk/f2fs.git/commit/?h=dev-test&id=2cdbbf025aac9f3dd54b9dec0a6603839a3171d3
>
> Allow me to merge it in -next sooner or later.

Ok, thanks for the confirmation that it's merged. I didn't mean to rush you,
just wanted to make sure it's not lost.

       Arnd
