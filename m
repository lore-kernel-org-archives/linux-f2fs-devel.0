From: Patrick Doyle <wpdster@gmail.com>
Subject: Re: Are there limitation to the number of named
 pipes/FIFO's supported by F2FS?
Date: Thu, 6 Sep 2018 09:31:22 -0400
Message-ID: <CAF_dkJAxydVSoWYck09iwfGmPEYyu0E5y1Ko914kd+j3GnyGOg@mail.gmail.com>
References: <CAF_dkJChk25fWa+bTndWa-qRsy6mW3Mj3uemXpk0QxLgY=fzeg@mail.gmail.com>
 <a24181da-6e5f-63de-d2fa-7c14c8ed592f@huawei.com>
 <20180905041210.GB15147@jaegeuk-macbookpro.roam.corp.google.com>
 <CAF_dkJCyf69FEM+RberH4NV2FZqa3b0tN+zQROkm3F1a_vFspw@mail.gmail.com>
 <8ffaeb7c-972e-f1d2-277d-0b02407f58ff@kernel.org>
 <CAF_dkJAzcBui=6ov=gbob3-T8u2n3QUyn3znSbLUkFjeg7nB8g@mail.gmail.com>
 <2d8ae907-a7ac-446c-d31e-d3c66ee4d8f6@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <wpdster@gmail.com>) id 1fxuO7-00037M-Sy
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 13:31:59 +0000
Received: from mail-oi0-f65.google.com ([209.85.218.65])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1fxuO2-00A8Jo-I0
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 06 Sep 2018 13:31:59 +0000
Received: by mail-oi0-f65.google.com with SMTP id m11-v6so20512845oic.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 06 Sep 2018 06:31:54 -0700 (PDT)
In-Reply-To: <2d8ae907-a7ac-446c-d31e-d3c66ee4d8f6@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: yuchao0@huawei.com
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net

On Wed, Sep 5, 2018 at 10:04 PM Chao Yu <yuchao0@huawei.com> wrote:
> On 2018/9/6 0:11, Patrick Doyle wrote:
> > What is the "Large nat bitmap feature"? (Now you've got me curious).
>
> That's the feature backed '-i' option, it can make image support more inode
> space.
>
> So if you use this feature in f2fs version lower than 4.17, there should be
> problem.
okay, so that was my problem.  My computer was running a 4.15 kernel
with 4.17 features enabled in my f2fs file system.

Ironically, since 4.15 is not an official "longterm" kernel listed at
kernel.org, I would not have benefited from a patch to the 4.14
kernel, unless somebody at Ubuntu picked up on this.

But I'm not going to try F2FS with the "Large nat bitmap feature"
again until/unless I upgrade to a newer kernel.  Thanks for helping me
figure this out.

--wpd

------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most
engaging tech sites, Slashdot.org! http://sdm.link/slashdot
