From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH] f2fs: avoid retrying quota flushes while the
 device is congested
Date: Tue, 16 Apr 2019 11:10:39 +0900
Message-ID: <CAD14+f3DftqxQghh9JwYNc=7jqAMvKqh3qXT8r7P=2Cn6YJ-Qg@mail.gmail.com>
References: <20190415130703.23983-1-qkrwngud825@gmail.com>
 <549ff0f7-6111-e844-d03d-1c3879d4ae36@huawei.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGDYo-0005EE-Jl
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 02:10:58 +0000
Received: from mail-qk1-f193.google.com ([209.85.222.193])
 by sfi-mx-3.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGDYm-009GWu-Tr
 for linux-f2fs-devel@lists.sourceforge.net; Tue, 16 Apr 2019 02:10:58 +0000
Received: by mail-qk1-f193.google.com with SMTP id a71so11223763qkg.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 15 Apr 2019 19:10:56 -0700 (PDT)
In-Reply-To: <549ff0f7-6111-e844-d03d-1c3879d4ae36@huawei.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Chao Yu <yuchao0@huawei.com>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Chao,

On Tue, Apr 16, 2019 at 10:58 AM Chao Yu <yuchao0@huawei.com> wrote:
> I knew this works in scenario cell phone suffers sudden power-cut frequently,
> actually, in a normal case, if there is race in between checkpoint() and quota
> updater, checkpoint() may suffer longer delay than before.

This was actually not a sudden power-cut scenario.
After passing the setup wizard
(the quota flush timeout might have happened during initial dex2oat process)
and simply rebooting, I always see "quota file may be corrupted, skip
loading it".

I personally investigated this quota corruption issue as I frequently
saw it on my
daily driver phone even when I never had sudden power-cuts.

> So I suggest we keep the logic as it is, since sudden power-cut is not a common
> case,

As I said, the issue is caused from a totally normal scenario.
A solution must be implemented imo.
Feel free to suggest a better idea/patch for me to test with.

> even in such case, quota sysfile is corrupted, we have another chance to
> repair it with fsck-tools, right?

This is an another potential issue. Android does fsck.f2fs -a on boot
and it does not
restore quota. Doing a run with -f fixes it, but not with -a.

This ultimately led the storage settings under the settings app to misbehave.

Thanks.
