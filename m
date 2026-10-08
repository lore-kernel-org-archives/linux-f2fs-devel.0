Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1F76CA6007
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  8 Oct 2026 05:47:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:MIME-Version:References:In-Reply-To:
	Message-ID:Date:To:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=8+XTaA67RIjqv1vdvHKaAnzSE4S+S5Q9bMZdE6P+woc=; b=fPxNoReyDMFJ1Mh9gprXUbRqUC
	NdBNbhLS/D1gZT8fGqIXGyS/4yAe+fTG2Y4KhtutYU7N0A9HaGkWwVFmZYo3R6BOLVq1g/lgELbKn
	9lGv/6Yj4Rtl2oRJl3ElYeHIfzZBTzGjUxqU+h1CM2OA3B0GivRGYBSfxvSQ+zlIO3As=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xEgy9-0004KB-DJ;
	Thu, 08 Oct 2026 05:47:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao@126.com>) id 1xEgy8-0004Ju-Cy
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 05:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Sender:Content-Transfer-Encoding:MIME-Version:
 References:In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Reply-To:
 Content-Type:Content-ID:Content-Description:Resent-Date:Resent-From:
 Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:
 List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KCwk0i7RJofeqxwqGOpS1AKnufaHtLGBH9GfdeVSM1Y=; b=PsYyGTiVbcKMXoR66/kOd2n4JC
 J4XC+qAGeBzcdKMAmnYpdFC3BWy20IE7STPTBnucRqm03d+gfm+uG1fx4FxO9VdZAxn2gzZ+2Nrlv
 CcZTrGLw9H+EO+KilqzRcKvf1aSLGJXSDmxaGRfJuP0ftiBF5WiEr4Ywx0SLeS0JueMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Sender:Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
 Message-ID:Date:Subject:Cc:To:From:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KCwk0i7RJofeqxwqGOpS1AKnufaHtLGBH9GfdeVSM1Y=; b=DihoOebZqocZiowuaVCcLcQWk3
 +rPH3wTOfQ9XyPURldRKPGlC7pXmAnu/Wgx7CiEJu98rxsFzwAUaONwths/+Hc/95FthRhh57fJaE
 sQa+iRpsQJRY7Xl3kK7Ost55+7dHiksdnxGI+HRGJXoHxsnX/AGI0j3ks2F9FOkNWB08=;
Received: from m16.mail.126.com ([117.135.210.7])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1xEgy3-0002dT-ST for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 08 Oct 2026 05:47:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=126.com;
 s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=KC
 wk0i7RJofeqxwqGOpS1AKnufaHtLGBH9GfdeVSM1Y=; b=Qh0JGSOd58yOfVCSxM
 MpPzgAQO3coGLf7ChSn3dKqu8Fdgy4WrlnhjzpT3etZC8hgOQi45eLKlN0s4O7rc
 k7cITe6V8rws8FWyA1wvZfRfJ8y0i/Yjd/uAlhIrdusOUo8LvCyg3S1zzIh56izP
 OJfrtLGw8e9lMt87Lbi8Nu9wE=
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn (unknown [])
 by gzsmtp4 (Coremail) with SMTP id PykvCgDnD8UvLsdq0VaXBA--.54425S2;
 Thu, 08 Oct 2026 13:46:24 +0800 (CST)
To: Daeho Jeong <daeho43@gmail.com>
Date: Thu,  8 Oct 2026 13:46:23 +0800
Message-ID: <20261008054623.732668-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_xYg6tDsYARD_7vvBpsQWHG0EtXNG1nHnufPUz0tyZakg@mail.gmail.com>
References: <20260915041909.2903887-1-zhaonanzhe@xiaomi.com>
 <20260915041909.2903887-4-zhaonanzhe@xiaomi.com>
 <CACOAw_xYg6tDsYARD_7vvBpsQWHG0EtXNG1nHnufPUz0tyZakg@mail.gmail.com>
MIME-Version: 1.0
X-CM-TRANSID: PykvCgDnD8UvLsdq0VaXBA--.54425S2
X-Coremail-Antispam: 1Uf129KBjvdXoWruw17WryruF43XrykWFyUZFb_yoWxKrbEvr
 1kGa4DCa4UtF9ay3WxCF4UKFZ3Gw12q3W5uay8Zr43ArykAFnY9Fs5Xas3AFySqFW3Gryj
 kFnxXrW0kry7ZjkaLaAFLSUrUUUUjb8apTn2vfkv8UJUUUU8Yxn0WfASr-VFAUDa7-sFnT
 9fnUUvcSsGvfC2KfnxnUUI43ZEXa7xRR4lkPUUUUU==
X-CM-SenderInfo: xq22xtbr6rjloofrz/xtbBsRAk82rHLjDcIgAA37
X-Headers-End: 1xEgy3-0002dT-ST
Subject: Re: [f2fs-dev] [PATCH v2 03/14] f2fs: support regular file buffered
 writes on large folios
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
From: Nanzhe Zhao via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net,
 Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

This reply should have been posted here.

> Hi Daeho,
>
> Thanks for the change.  I would like to integrate it into v3, folding it
> into the "f2fs: support regular file buffered writes on large folios"
> commit.
>
> My patch adjusts the signature of 'prepare_atomic_write_begin()': for large
> folio compatibility, the 'unsigned int len' parameter is replaced by 'pgoff_t index',
> so that the helper can be called in a loop from 'prepare_large_folio_atomic_write_begin()'. 
> I found that len was a dead parameter in the original 'prepare_atomic_write_begin()', 
> so in v3 I will not pass blen to 'prepare_atomic_write_begin()'.
>
> Thanks,
> Nanzhe

Sorry for the wrong threading.

Thanks,
Nanzhe



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
