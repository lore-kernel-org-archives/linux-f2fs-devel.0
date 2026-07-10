Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 331AAC43458
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 10 Jul 2026 03:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=cbPSfyJhxl7fImD9t1d9EdGhsW51ZZSMsbJWj83FpI8=; b=BEtbFk11SbBwdd9cCx9hsA9hqS
	X7ubZidnUNHp6rU6ZuhU16g7dolby4HZ0fvxq3Q8LPXPr5xhIqsFGnnRD+O6jeeDLC2ZOhdlPvgi0
	NBaD6Tt/QxbDM7qtH+ta2zTTlIq/jWOTezX7nyks4o+V0gopepTU0hf6vxi6Pf1uAE70=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wi1Xg-0002AV-5t;
	Fri, 10 Jul 2026 03:04:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1wi1Xf-0002AO-3I
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 03:04:40 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=S6Uitytt2+vFrXVrmF3l1mzokRJyz/mIzlRDo6TPLDE=; b=gzthwquKoZCKFD5rR6CLlAAau/
 8OgofQA4S5jN9L61gMZ1o6+apqzD2xRngRfXOuZ7TG6rT6tf17xnCFAdbjOe/fQMStwrp1TTczq8s
 Pv/PGq6gvdo5T5jDFOx5Y4nrrTaCxXOhVeklCtIkooIdxkbChgQEfbaYztdMhDYb/Xn8=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=S6Uitytt2+vFrXVrmF3l1mzokRJyz/mIzlRDo6TPLDE=; b=QNZnIEgZDqyWJGjscf8STbUiJv
 wjmckNIp69gbmMZl/QoRt3XXyOEJscgssRTto8nRaH3CGuPr1uYy1k3FTf7RHG+7utgB3KJBLC/UV
 TjfkUbhKQSQfipBoq3W24BSDcjzHTlz0EW2Bl3Qojlietf7b8jfmykHhJ26uZOhG0Ngc=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wi1Xc-0001cv-6y for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 10 Jul 2026 03:04:40 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id EC1214143A;
 Fri, 10 Jul 2026 03:04:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33C481F000E9;
 Fri, 10 Jul 2026 03:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783652668;
 bh=S6Uitytt2+vFrXVrmF3l1mzokRJyz/mIzlRDo6TPLDE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=eWNrKMdVBLAfOfyglz+lvSWZFkqR8yTucnRjXUZRamnaIIElqi7dD9Ff3vjPWNy9g
 QdOdc5SDi54kTfk/kvc/x6JZBVoL3Vd5ySJHfvflAFm9nVP4D08/ySPNfioi1fv+ku
 qBxcxURlKh9eiPyHbgpLaiSMRpNzWaq5PWo9kCzImXISFeg3O9q0DjRwIjXR/NL8tK
 NeK7be7n5o8YOm0y8GjG/K53fmQJgWv+lOTFTi4aIqzCZuFgX+diBg2QcMZfbdOUCF
 Aw+j+q7fgdTYLUL6Hp9am2NqrgeI3BZdwhGjyxbBLrVjGBTutWMdE9uxqaYOiOUAAY
 Kt7paX0M59pmA==
Message-ID: <835e14b7-17d7-4f9c-b84b-593a0f2d5982@kernel.org>
Date: Fri, 10 Jul 2026 11:04:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
References: <bc4b29f0-8309-4a36-bdbe-b5f375aec31a@kernel.org>
 <20260710011534.2307696-1-zhaonanzhe@xiaomi.com>
Content-Language: en-US
In-Reply-To: <20260710011534.2307696-1-zhaonanzhe@xiaomi.com>
X-Headers-End: 1wi1Xc-0001cv-6y
Subject: Re: [f2fs-dev] [RFC PATCH v2 02/10] f2fs: carry subpage offset and
 count in write IO
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 linux-f2fs-devel@lists.sourceforge.net, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Ryan Roberts <Ryan.Roberts@arm.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, Pengfei Li <lipengfei28@xiaomi.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/10/26 09:15, Nanzhe Zhao wrote:
>> How about cleaning up w/ below macros?
>>
>> #define F2FS_FOLIO_INDEX(folio, fio)    (folio->index + fio->folio_offset)
>> #define F2FS_FOLIO_BLKCNT(fio)          (fio->folio_blkcnt ? fio->folio_blkcnt : 1)
> 
> F2FS_FOLIO_XXX naming seems a bit weird to me :). It does not show that
> we want to use the folio subpage index associated with fio, or the blkcnt
> recorded in fio. I think names like F2FS_FIO_LBLK and F2FS_FIO_BLKCNT
> may be better?

Looks fine to me. :)

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
