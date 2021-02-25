Return-Path: <SRS0=tfP1=H3=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68C33C433DB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 25 Feb 2021 09:18:44 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id DB26664E90;
	Thu, 25 Feb 2021 09:18:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org DB26664E90
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=collabora.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linux-f2fs-devel-bounces@lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.90_1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1lFCnA-0001dp-AK; Thu, 25 Feb 2021 09:18:40 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.90_1)
 (envelope-from <arnaud.ferraris@collabora.com>) id 1lFCn8-0001d8-Ox
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Feb 2021 09:18:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=0AAuuDo9Su5VHPsB9/3PQJ/3vl9YXb0Flqoopmnihqo=; b=NPp1h5C9MjFfTE7kKk8hmxJ2pz
 M/+NvoTUV8vBgw3f5ASWT9hyW3KtG1Dgg3m5tY0TFLtCcvyeFh5z7IOMJscB3wy+42Y1UrN/D5c30
 aYKmaIwb49alwnx4/zsY/1NzAdmMDItWzobawqDi+60vX9iMA6wbG3zwSDaHLGwyHi8o=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:MIME-Version:Date:
 Message-ID:From:References:Cc:To:Subject:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=0AAuuDo9Su5VHPsB9/3PQJ/3vl9YXb0Flqoopmnihqo=; b=nCfvs8d9ZpM2uGVlhQ1bIVO4Ep
 w5k5Ur5yrzqR5imHANt/Ci0b2xPLuiAkOUm6JvGCWmtTJ/YVr0M1eG7q22vjifo/kI65O3RxcSogA
 pR8F2M2/S3mpcMU4l+iTz1IM3Fp24xTGQxkFN8VuUZAp177VYDa0WNEUeM9T4bOpLCEc=;
Received: from bhuna.collabora.co.uk ([46.235.227.227])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1lFCn3-0002if-Oe
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 25 Feb 2021 09:18:38 +0000
Received: from [127.0.0.1] (localhost [127.0.0.1])
 (Authenticated sender: aferraris) with ESMTPSA id 7AA451F44F17
To: Chao Yu <yuchao0@huawei.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20210224170327.237831-1-arnaud.ferraris@collabora.com>
 <4f3d7d52-a5bb-e219-229a-7fee728c025f@huawei.com>
From: Arnaud Ferraris <arnaud.ferraris@collabora.com>
Message-ID: <7b62ee90-30e0-1840-9d87-673f72eb4355@collabora.com>
Date: Thu, 25 Feb 2021 10:18:25 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.1
MIME-Version: 1.0
In-Reply-To: <4f3d7d52-a5bb-e219-229a-7fee728c025f@huawei.com>
Content-Language: en-US
X-Headers-End: 1lFCn3-0002if-Oe
Subject: Re: [f2fs-dev] [PATCH] resize.f2fs: fix new reserved segments
 calculation
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: quoted-printable
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi,

Le 25/02/2021 =E0 02:50, Chao Yu a =E9crit=A0:
> On 2021/2/25 1:03, Arnaud Ferraris wrote:
>> f8410857b7a81b1b347253fcca713d8b105e9e7b changed the way reserved
> =

> Commit f8410857b7a8 ("f2fs-tools: zns zone-capacity support") changed ...

Will do.
However, I didn't test that patch enough as it can corrupt large
filesystems, I'll dig a bit deeper and post a v2 asap.

Thanks,
Arnaud

> =

> Otherwise, it looks good to me.
> =

> Reviewed-by: Chao Yu <yuchao0@huawei.com>
> =

> Thanks,
> =

>> segments count was calculated in `mkfs`, but that wasn't reported back
>> to `resize`, making it impossible to resize a filesystem in some cases.
>>
>> Signed-off-by: Arnaud Ferraris <arnaud.ferraris@collabora.com>
>> ---
>> =A0 fsck/resize.c | 4 ++--
>> =A0 1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fsck/resize.c b/fsck/resize.c
>> index 46b1cfb..3ee05f7 100644
>> --- a/fsck/resize.c
>> +++ b/fsck/resize.c
>> @@ -148,8 +148,8 @@ safe_resize:
>> =A0=A0=A0=A0=A0 /* Let's determine the best reserved and overprovisioned=
 space */
>> =A0=A0=A0=A0=A0 c.new_overprovision =3D get_best_overprovision(sb);
>> =A0=A0=A0=A0=A0 c.new_reserved_segments =3D
>> -=A0=A0=A0=A0=A0=A0=A0 (2 * (100 / c.new_overprovision + 1) + 6) *
>> -=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 g=
et_sb(segs_per_sec);
>> +=A0=A0=A0=A0=A0=A0=A0 (2 * (100 / c.new_overprovision + 1) + NR_CURSEG_=
TYPE) *
>> +=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0=A0 round_up(f2fs_get_usable_segments(sb),
>> get_sb(section_count));
>> =A0 =A0=A0=A0=A0=A0 if ((get_sb(segment_count_main) - 2) < c.new_reserve=
d_segments ||
>> =A0=A0=A0=A0=A0=A0=A0=A0=A0 get_sb(segment_count_main) * blks_per_seg >
>>


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
