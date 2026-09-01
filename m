Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 65938C61DD3
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  1 Sep 2026 20:29:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:MIME-Version:References:
	Message-ID:To:Date:Sender:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mgUN7ZGJe7UfyVKZcu0kR/2udVZdeLTE5ps0prxEgQE=; b=jzAyKm7XJBtuZ1SoNcVIepdINN
	JGOg1xJxFFEcHcGp65UlBiO2o4TPdNqdQzdlcfidBFZXSknCzURd+vr31PRW/R5f/NDvV0rTWWrXs
	R++wRnm7k2S15FPjTSvWRINTuVR5TTIomXovTzehV+dfI0qaiUr99bm/EcWzqDFOYqAc=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x1V6w-0007rA-Dm;
	Tue, 01 Sep 2026 20:29:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <zlang@kernel.org>) id 1x1V6s-0007r1-LB
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:29:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=In-Reply-To:Content-Type:MIME-Version:References:
 Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=Aw7+SfO86yNdZCHF72l5vGVibm
 KBNBj7X9mewI80TqzZiatTah4pRimXL5+mymN4PS7IlRBvMfnlj7cpyo84YmexxQ0ojvzGHenAVAO
 Da3iF909O28/c8F7KTP+vE1ZUBWiSw+7UFv+XC7dDEkEcMvvZOgxPYiIrhkEPqCtzMjA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To
 :From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=; b=K1EEMLCVCtPajOKhdv5MKjexpM
 TFChRVsKfnu03/dGQ1Hf40JgoXjXHhlpdORSPIZ8dIsSqofOuykE7a+AUXrBnN73kTlCq0XfIWFbW
 +2P/IpJGe0iOWSjBK13kTOq+HFu1OeMnvaojZSK/Ny63Q/eiURR1BkqJSrE+tQq7ttLs=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1x1V6s-00042V-2X for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 01 Sep 2026 20:29:35 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B2D6D4369E
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue,  1 Sep 2026 20:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7E891F000E9;
 Tue,  1 Sep 2026 20:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788294568;
 bh=47DEQpj8HBSa+/TImW+5JCeuQeRkm5NMpJWZG3hSuFU=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To;
 b=GHnc9AkMu8ce9n+HMBvbAn8Krm1Gsxh5hDD1NQ1ORMazndd1HS5Sx8sLT4L0ZVE85
 CjFJ/EADfsbbqTS6ffNi/Tftm43kSBjFiscGjTIImubwVFY7HfXlidLB/pZhTRnliN
 a4XWeiCk73rMN8fgQfKvj8ArcdQnl/BKJVWrgjwLh5Ze909jVnfMlyygkCQ0ws2z+u
 ww1ByKFUujuPbPMQYWK8uTlkh/ALd36LoWiM9JuqcNk52ddaFNHjyu1rmKl9v6Azrg
 C6tsysr8aheQGci7u4LU1KK9m+vZKCbkcBNcRqrRXQ3xxq2Am7n9VmXEBsBxvuCPYh
 X9AChjoqqLvjA==
Date: Wed, 2 Sep 2026 04:29:22 +0800
To: Anand Jain <asj@kernel.org>
Message-ID: <apc0FKW7Zuez4SeB@zlang-mailbox>
Mail-Followup-To: Anand Jain <asj@kernel.org>, fstests@vger.kernel.org, 
 linux-btrfs@vger.kernel.org, linux-ext4@vger.kernel.org,
 linux-xfs@vger.kernel.org, 
 linux-f2fs-devel@lists.sourceforge.net, djwong@kernel.org
References: <cover.1784949154.git.asj@kernel.org>
 <7afe9c82cce1540ea0f8cc1f3d1306c24b6cc84d.1784949155.git.asj@kernel.org>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <7afe9c82cce1540ea0f8cc1f3d1306c24b6cc84d.1784949155.git.asj@kernel.org>
X-Headers-End: 1x1V6s-00042V-2X
Subject: Re: [f2fs-dev] [PATCH v8 11/13] fstests: verify exportfs file
 handles on cloned filesystems
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
From: Zorro Lang via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Zorro Lang <zlang@kernel.org>
Cc: djwong@kernel.org, fstests@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, linux-xfs@vger.kernel.org,
 linux-ext4@vger.kernel.org, linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
