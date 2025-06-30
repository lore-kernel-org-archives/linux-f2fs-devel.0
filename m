Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5DD59C8302D
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 30 Jun 2025 11:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=+RtMhxMOEbdDjVvDzxU02EsJL7IuwUYaGqURzWDMQs8=; b=EQIZhYvgyL2EO5TsSTE/0+YPNE
	teANc88URbEhohwogKlagN6N8BnCa5a2PUCH12AB/mGQioZ0SyrrT6LhdMI1T5ANyNcUk+iMsIVzJ
	WQKQK7P7j6tCvUxkfvObxkEGYcqQoVI8Ps/hI78nqbvBNzSty5RfMF9PXzIXQGIZ0WFg=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1uWCQX-0001AL-Qq;
	Mon, 30 Jun 2025 11:11:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1uWCQX-0001AE-94
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jun 2025 11:11:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Njj1BBkeCyrJnPJ9OPIErCDlntEu0E8zVGj3izInCOA=; b=Qy+RFvU5k2qIBi+SHoDBHxtQSF
 wlOB1XEBfUKTLXqvMvAWiY/woY4VXjPU/DGDWAmLpV8dSGxT5thcbWoh/sW0mV3jm0Van58rDOM+a
 vw0iG3tae6+pq6skhrtIx3HrlQwd542DUvl7wGYUGZIxATDo/NOoLsBsIdQTTK8PcWiY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Njj1BBkeCyrJnPJ9OPIErCDlntEu0E8zVGj3izInCOA=; b=nCj4wvnQlqw6Ja3ZwAB6ui1EGU
 pelNxpfajgKP1E1CCcf2Q5f+2/Rufh1hN02k3x44LwaXKbE4Zh4PyQ2l3vP/MlC1+Yqr+VNogRc9L
 yGntH/c4GpN/biL0jqspw1i3mXyLmQ0e/FiM2Zzxm3Pqtf2PCYia51MMbotSOg21L3fk=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1uWCQW-0000JF-U5 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 30 Jun 2025 11:11:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 3BDE161126;
 Mon, 30 Jun 2025 11:11:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D91FC4CEE3;
 Mon, 30 Jun 2025 11:11:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1751281910;
 bh=APMVTdrrYAXWsh7dmspBZyKji07itzv/fr34xibM038=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=rTiUnE8lI3kPva5JmOS/nlXp22FS3FKhxRaatV0WsIoxkcXCSPHBVcyKa4HZcee/e
 q9MkECp0jPyE260x09CzsRZHBltKH96k/8tvbW4Oi/xVGnOGhIAyNAnEqU7LVOtqG/
 m713sj/TOeGuxqy9wijpTt8BzuzT2rrWZ/mq68S5+DBI7d38HNaZfQk/ZihNNiCb17
 GXXRUWb+ihB3U4HL3q3VC8kg0ePFTG6oDNVhb50CybMO73vW7x/DrGC8fEgkCY54PM
 iEj5Eg2DpAQNJDRPN+zVU2G3TMT3synMNcuKAcVv8HwuV5P2lhzwXJTsjR6vZAibaV
 kDiZ1Tomv7Xsg==
Message-ID: <f9a2bb12-37d4-42a2-b4cc-20959878dfbf@kernel.org>
Date: Mon, 30 Jun 2025 19:11:47 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: wangzijie <wangzijie1@honor.com>, jaegeuk@kernel.org
References: <20250630095454.3912441-1-wangzijie1@honor.com>
Content-Language: en-US
In-Reply-To: <20250630095454.3912441-1-wangzijie1@honor.com>
X-Headers-End: 1uWCQW-0000JF-U5
Subject: Re: [f2fs-dev] [PATCH v5 1/2] f2fs: convert F2FS_I_SB to sbi in
 f2fs_setattr()
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
Cc: feng.han@honor.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 6/30/25 17:54, wangzijie wrote:
> Introduce sbi in f2fs_setattr() and convert F2FS_I_SB to it. No logic
> change, just cleanup and prepare to get CAP_BLKS_PER_SEC(sbi).
> 
> Signed-off-by: wangzijie <wangzijie1@honor.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
