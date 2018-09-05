From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Wed, 5 Sep 2018 12:11:13 -0400
Message-ID: <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
 <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fxaPD-000538-88
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 16:11:47 +0000
Received: from mail-oi0-f66.google.com ([209.85.218.66])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fxaPB-009EPC-Hi
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 05 Sep 2018 16:11:47 +0000
Received: by mail-oi0-f66.google.com with SMTP id x197-v6so14673490oix.5
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 05 Sep 2018 09:11:45 -0700 (PDT)
In-Reply-To: <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: chao@kernel.org
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 5, 2018 at 11:57 AM Chao Yu <chao@kernel.org> wrote:
> If there is any chance to retry f2fs, let f2fs guys know anything we can help. :)
>
Thank you.  If I have the opportunity to do that, I'll let you know.

As far as opportunities are concerned, I could just buy (have my
employer buy) another 1TB SSD, stick it in my system, format it with
F2FS, and see if I run into these sorts of issues again.  All that
would take is time, which is in short supply right now.  But it's not
out of the question.

> >
> > For your own reference, I am running my production system on Ubuntu
> > 16.04 LTS with a "4.15.0-33-generic" kernel.
>
> Large nat bitmap feature was supported in 4.17, old kernel can not recognize the
> feature flag set in mkfs, to make sure, are you porting last f2fs to 4.15?
What is the "Large nat bitmap feature"? (Now you've got me curious).

Would that have been turned on by default with the 1.11.0 version of
mkfs.f2fs I used to gain access to the "-i" option?

>
> To Jaegeuk,
>
> Anyway, I think we'd better to add some warn info during formatting with an
> upgraded mkfs, so that it can reduce the possiblity of encountering incompatible
> issue between new mkfs and old kernel.
I think it would also be worthwhile also to submit patches to the LTS
kernels that would check for an inhibit mounting of F2FS filesystems
that have features unsupported by the kernel.  If that is already in
place, then I shouldn't have been able to mount my f2fs partition if
it had the "Large nat bitmap feature" enabled.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
