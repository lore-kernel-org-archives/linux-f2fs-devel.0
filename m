Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 46509C5DF94
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 24 Aug 2026 07:05:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=EKwHT6yE1a/4wOKu4sMB7/MShMDDlH7L4JAoiDsuWhY=; b=MhzjgR2dpFMe9XVt+YKCTH0Kjg
	s2M3h6mSlRttEoU3wwhKSQuGnUR9U3HXvj68LhqiHMzF2gLgr1ntAHTlPgeQcfUpGBf7txWPvL0vY
	KkyJMNQUXfu/jGyPKKC0Fzxvcch1sdzT1wmzwMT/mjtV3bccjs+dMcLI6Rf7Keqh+GM0=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wyOkY-0000BI-H1;
	Mon, 24 Aug 2026 07:05:40 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wyOkX-0000BA-96
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:05:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=t/xMoMYSD6XciRri3+suQ8PHhr1s8NaBhYq7YB/JY3Y=; b=eQKWKpvOfgDP42r+OPHpY3ohIv
 Pdpqmsy8bN6i5OKGLhyPowAKTbq/m2khcqJLZT1RIjS7iJeF/1CzmkLj55Kz1PF2jwC7cybwlQVXu
 6e1qsI+uS3sWxUqVDd/OVGuhraIoScZf55GJGAnmarg6EUQr+ICC6sNutLAnMIC+8bE0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=t/xMoMYSD6XciRri3+suQ8PHhr1s8NaBhYq7YB/JY3Y=; b=g4xIPk7lFUlXXY4nUME9hamsDi
 xgBWPEh4ZxjPGFustoXYyF6aw6LJHo+H39rhsKK4f5wnuDY9IqOVU2SdD+V2vqOK8vNA8CvVbq19P
 +2rLRxWvWTTM3SwoShGuvh/OOMm+bpWqxJKLtutwlWY0oeDDvCQiMVL3hx7/CIamy+1I=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wyOkT-0004Af-DD for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 24 Aug 2026 07:05:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id C761F600C8;
 Mon, 24 Aug 2026 07:05:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279D51F000E9;
 Mon, 24 Aug 2026 07:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787555131;
 bh=t/xMoMYSD6XciRri3+suQ8PHhr1s8NaBhYq7YB/JY3Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=mdtT6ya4HbSImTjij/+puBesKzK3j9HRahVmvLqnnTOmWE6CekBp3cEpMXnQp7u71
 L4UDH34TldJLSZupnUK+HKsIVwaQLNuSRnQcoHsEjX3Fdqu5wC6boOX5wv2q/waeeU
 ZJai8DLJ65tYb+ix1ZrkNHYYuV+h2QNZqmm9GWNRkq+8GySSS7BV7tVJHB1isJBJX1
 4Rjw8M19cg1uytq/OfFIOvABUK/siU1jVrWKwQZwuZR+b8dt6+u1jU8IGEgyCe1r3h
 bFQYmypENl9YuoQ2fhETOBwp9si0flTWZ69Pt8si24YUHmGVlFQNZ9sSv0tjEHu0Uh
 XRunhBkHn7sfA==
Message-ID: <d513fec2-6cf9-45d0-bf49-ee9132a68054@kernel.org>
Date: Mon, 24 Aug 2026 15:05:28 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wenjie Qi <qwjhust@gmail.com>
References: <20260820031721.12218-1-chao@kernel.org>
 <20260820031721.12218-6-chao@kernel.org>
 <20260823125546.3229535-1-qiwenjie@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260823125546.3229535-1-qiwenjie@xiaomi.com>
X-Headers-End: 1wyOkT-0004Af-DD
Subject: Re: [f2fs-dev] [PATCH v1 05/12] f2fs: cache: use meta cache
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
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Wenjie Qi <qiwenjie@xiaomi.com>, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 8/23/26 20:55, Wenjie Qi wrote:
> Hi Chao,
> 
>> struct f2fs_cached_block *f2fs_get_sum_cache(struct f2fs_sb_info *sbi,
>> 		unsigned int segno)
>> {
>> 	if (unlikely(f2fs_cp_error(sbi)))
>> 		return ERR_PTR(-EIO);
>> 	return f2fs_get_meta_cache_retry(sbi, GET_SUM_BLOCK(sbi, segno));
>> }
>>
>> entry = f2fs_get_sum_cache(sbi, GET_SUM_BLOCK(sbi, segno));
> 
> `f2fs_get_sum_cache()` applies `GET_SUM_BLOCK()` to its argument.  Its other
> callers pass a logical segment number, while this packed-SSA path passes an
> already translated value.
> 
> Is the argument contract of `f2fs_get_sum_cache()` a logical segment number
> or an already translated block address?

Oops, should use f2fs_get_sum_cache(sbi, segno) here.

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
