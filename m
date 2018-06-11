From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [GIT PULL] f2fs update for 4.18-rc1
Date: Mon, 11 Jun 2018 10:34:24 -0700
Message-ID: <CA+55aFw13-=qJ44s+_SM7csCPu0EeQf4bSzsf+tfPes=cBVBOg@mail.gmail.com>
References: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <linus971@gmail.com>) id 1fSQiJ-0005X4-9B
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 17:34:43 +0000
Received: from mail-it0-f67.google.com ([209.85.214.67])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fSQiH-000W8T-VD
 for linux-f2fs-devel@lists.sourceforge.net; Mon, 11 Jun 2018 17:34:43 +0000
Received: by mail-it0-f67.google.com with SMTP id p185-v6so11947586itp.4
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 11 Jun 2018 10:34:41 -0700 (PDT)
In-Reply-To: <20180611165212.GA6783@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, Eric Biggers <ebiggers@google.com>, Chao Yu <yuchao0@huawei.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, "Linux F2FS DEV,
 Mailing List" <linux-f2fs-devel@lists.sourceforge.net>

On Mon, Jun 11, 2018 at 9:52 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
>
> Eric Biggers (4):
>       f2fs: call unlock_new_inode() before d_instantiate()

Btw, in my merge, this got superseded by commit 1e2e547a93a00ebc2158
("do d_instantiate/unlock_new_inode combinations safely"), because the
ordering of that d_instantiate() and unlock_new_inode() was subtler
than just doing the unlock first.

I can't test the end result, so you guys should double-check whatever
xfstest you ran originall, ok?

            Linus

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
