From: Jaegeuk Kim <jaegeuk.kim@samsung.com>
Subject: Re: [PATCH 2/2] f2fs: use sbi->wr_mutex for write bios
Date: Mon, 18 Nov 2013 18:30:00 +0900
Message-ID: <1384767000.26319.18.camel@kjgkr>
References: <1384765922-24028-1-git-send-email-jaegeuk.kim@samsung.com>
 <1384765922-24028-2-git-send-email-jaegeuk.kim@samsung.com>
 <5289DC0C.30909@cn.fujitsu.com>
Reply-To: jaegeuk.kim@samsung.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <linux-fsdevel-owner@vger.kernel.org>
In-reply-to: <5289DC0C.30909@cn.fujitsu.com>
Sender: linux-fsdevel-owner@vger.kernel.org
To: Gu Zheng <guz.fnst@cn.fujitsu.com>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
List-Id: linux-f2fs-devel.lists.sourceforge.net

Hi Gu,

2013-11-18 (=EC=9B=94), 17:21 +0800, Gu Zheng:
> Hi Kim,
> On 11/18/2013 05:12 PM, Jaegeuk Kim wrote:
>=20
> > This patch removes an unnecessary semaphore (i.e., sbi->bio_sem).
> > There is no reason to use the semaphore when f2fs submits read and =
write IOs.
> > Instead, let's use a write mutex and cover the sbi->bio[] by the lo=
ck.
>=20
> My god, I just sent out an almost the same patch, do we have a telepa=
thy?:)

Wow, it seems so. :)

--=20
Jaegeuk Kim
Samsung

--
To unsubscribe from this list: send the line "unsubscribe linux-fsdevel=
" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
