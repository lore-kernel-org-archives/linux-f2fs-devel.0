From: Ju Hyung Park <qkrwngud825@gmail.com>
Subject: Re: [PATCH 2/2] mkfs.f2fs: make the default extensions
 list much more sensical
Date: Wed, 17 Apr 2019 16:14:00 +0900
Message-ID: <CAD14+f2+67Q7gSwGjjhJ8Nr1uL+DTRSXpbu-TdMMF+g6x1-Dfg@mail.gmail.com>
References: <20190416064355.29712-1-qkrwngud825@gmail.com>
 <20190416064355.29712-2-qkrwngud825@gmail.com>
 <CAD14+f1JW6yaJFmuZRU2vJcREXScwm59nRvp1x2Y9Zt6n3MFXg@mail.gmail.com>
 <20190416203947.GA84362@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <qkrwngud825@gmail.com>) id 1hGelu-0006PF-W5
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 07:14:18 +0000
Received: from mail-qt1-f196.google.com ([209.85.160.196])
 by sfi-mx-4.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.90_1)
 id 1hGelt-00BS8B-PR
 for linux-f2fs-devel@lists.sourceforge.net; Wed, 17 Apr 2019 07:14:18 +0000
Received: by mail-qt1-f196.google.com with SMTP id t28so26260139qte.6
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Wed, 17 Apr 2019 00:14:17 -0700 (PDT)
In-Reply-To: <20190416203947.GA84362@jaegeuk-macbookpro.roam.corp.google.com>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net

Hi Jaegeuk,

On Wed, Apr 17, 2019 at 5:39 AM Jaegeuk Kim <jaegeuk@kernel.org> wrote:
> Thank you for heads up. Taking a look at two patches, I think it'd be fine to
> merge them into single patch. Let me know, if you have any concerns.

I'd prefer not merging it as a reorder was done prior to this patch.

If someone was looking at the extensions list closely, they'll have a
hard time understanding which extensions really changed.

But I believe this is a nitpick at this point. I see you already
merged the patches to dev-test, feel free to leave it as-is.

Thanks.
