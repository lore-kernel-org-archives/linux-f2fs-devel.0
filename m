Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 671E1C61DBD
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 26 Aug 2026 02:24:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=hwbrbbq/vNnVyj0OMTsDEc5xh6uvtJRNUIhOUrKO4c4=; b=VpT6Nz+dx7Ge6VOY24tacIs/1l
	vMI35oQvsflI8k+QZBJIB7o7Za/tEnF5dy8AI6ls/4I3MuT0J88tjfb9Mq6XoCCmb+hEY6Ut42GqK
	XPW5B1B1Y0iUiUHj49pj7aQLnB+UAC/XUvD2ip8oPtqJEAxh+Cwy0TiHj3b9+g94ri4I=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wz3JV-0002KD-9G;
	Wed, 26 Aug 2026 02:24:30 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <qwjhust@gmail.com>) id 1wz3JT-0002K5-Ks
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:24:28 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=94VxW87XCDtaltd8hui8AiZ4PEzSf58uMDIvvML+bow=; b=iRhmc6AVNQNK73Mw4eCmXd6CuE
 LVL5WFUg+p0gM5H6yDUYllm26utBE7ADZaC54Miq7vTdcmouY2IKkeB4cuq0pwC9WSyqSHTnUbB1U
 TWl1xxEURwB8/77XoFJnLb55/uy6jQyIc1bvCFMZl6OZtAwv2dmVxCh6qcNyJS5bWzKo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=94VxW87XCDtaltd8hui8AiZ4PEzSf58uMDIvvML+bow=; b=NpUiCjKTVTVmXMmZo7XQ0eHaKQ
 IwcQV6uBKLBXIJXUBgtXIoD2VCFZfN3HYc9nx19EDh8sWxBLdJNu/b2FsVBB2+9vxUB/JRIMb8GY9
 1bfDsitRMb3Bsxg+8wklHMNcYL0BWdhmI1z6j2t3Ud71q7laUpXujZaqKFt1G5kQXXLc=;
Received: from mail-pl1-f178.google.com ([209.85.214.178])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1wz3JT-0001uu-Tp for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 26 Aug 2026 02:24:28 +0000
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d6e954afbdso3853855ad.2
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Tue, 25 Aug 2026 19:24:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787711062; x=1788315862; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=94VxW87XCDtaltd8hui8AiZ4PEzSf58uMDIvvML+bow=;
 b=kFOMrUnr5nzdRJLYCQ427W3aMs1XpwovOg+j0dJqkCj5HsSvtBXEHJXHhvB4m9HIqQ
 7J6Fq6scXXuD98ccNoP485DJUQjRUPeoGuNoHfh4k+GzjxcbrVuKztIDlLk7vrNCVlVz
 rquKO4tEFDRZBeOKusvlDDMajGsfCoT5/zZ2Cnuz9hgQUb2/XxZ8q0Gllm46qLPnedZR
 Hryp2A2kUKQEnJuN5zSTqUzwQOqQfR6kpVylBYc9JjLbgp6qHzaKg3W6tpnqg09omglX
 Vy6td6j8b2nLj4pY9hEhMRvUAkgUaX6pusAF/pQBXS7B5D++Kxi34JIWioClHDS2jYaW
 bGyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787711062; x=1788315862;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=94VxW87XCDtaltd8hui8AiZ4PEzSf58uMDIvvML+bow=;
 b=Xzxsb74TLCQ5VZpEk8viPYq0/rQLbjkEHtFe78VoWvtIq2/Bkw8juATfZ0HZLOYmE4
 ZkTd02Q07SnAl0QKQRglNs+neBNJMdDUNi4JQgUEZ3jifOozidnP37I4afx6o58N3hR2
 /FnhlLtoDG7UVHjLMrrH62mNJJ6cbCRhSML4bPwVW3hv2q3us7N+enm7OI/E1XAeGQ11
 ZrsgBvnHzZGhXw36iO8wRH6Ue259Oi4jjsADX4noYRiTRSWmBltoE2w5POmPgz6PcPV7
 uohkjqpVo+ZYI8gYSnay3Wd/KTha4aDNCXuJmmZ0/8FhxJhBs8jmKyZag2Kc+LsnHgku
 xjgQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RpUOakt6RPhIAH7kLIJAD8UN1Yij9UMhh9nw/a0lsZCENWQAcl+eOOvh6UP5W4raP6HSOzeXJ1BVZS0naPrZ/nV@lists.sourceforge.net
X-Gm-Message-State: AFuF++luGGPej/3BrEMY4Vw2BLt4AfTXvAMEPs725+AkYpqCWgKA24L0
 rTr1m+iLUoFX8HJ0IwjjIZmSz5YZD6r19/Edx6IgvRUcGmx7MU1fg5JL
X-Gm-Gg: AR+sD10kixMGfaWbvAdF1IPMinr4d8p8U5vspnGrcVevBv0GoLIkZPQ+rO2kIv0tJ1O
 UOjfRW6efQdmUJnJKopLO+1HaZBnAdETSBkKC9AgaGp7Dn8/hynfh9XgkVGRnpGLX93xcOYIKam
 WauNqjlgFGuk0fxl9N++xmuHM2OZda2j41wyvOuuvPGeACcD/ysw+KOy3gwsrHFVpLvPFQqkd8k
 xQOBLUM09Jc9Mxob/QD+EG6WkaIAISgYeItJTwBXt3wfoQcBrMyRubBSaxCILuRTm9C5tDtuGbY
 MksJVLoOHQGjmyI3i8nRRgKurSs4U8b7kVOVPsaKl1KQF0GM3r1XAbswOOhHzECYPu30IexbDl8
 1ExaUSRFk9dhtzmIfntkuVmyeXrtvJDmCe5tWOXthKXkwKF2oeo2MTHiGIhDEPNmF7cUPqHXBME
 kLK58ORvLEX/w8pvqmG2itnT7r1/ptsgkDs0wp9AooErWoktmnIwFrjgvDDb12ttNdnH79OnxLL
 OooCXvFJaYaaGwbtrwiqnok
X-Received: by 2002:a17:90b:35c3:b0:395:5f43:4ec4 with SMTP id
 98e67ed59e1d1-3966cdfde45mr7835216a91.0.1787711062116; 
 Tue, 25 Aug 2026 19:24:22 -0700 (PDT)
Received: from qiwenjie-ThinkCentre-M760t.mioffice.cn ([43.224.245.241])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3966875bbadsm1961923a91.5.2026.08.25.19.24.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 25 Aug 2026 19:24:21 -0700 (PDT)
From: Wenjie Qi <qwjhust@gmail.com>
X-Google-Original-From: Wenjie Qi <qiwenjie@xiaomi.com>
To: daeho43@gmail.com
Date: Wed, 26 Aug 2026 10:24:14 +0800
Message-ID: <20260826022414.2503244-1-qiwenjie@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
References: <20260825083738.526423-1-qiwenjie@xiaomi.com>
 <CACOAw_y0FwrNasvN5jWv4QLuXnuDhKW3hoOc3NM8vdX6oOxXYg@mail.gmail.com>
MIME-Version: 1.0
X-Headers-End: 1wz3JT-0001uu-Tp
Subject: Re: [f2fs-dev] [PATCH] f2fs: propagate resizable_tail_secno mount
 option
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
Cc: daehojeong@google.com, qwjhust@gmail.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, qiwenjie@xiaomi.com,
 jaegeuk@kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Daeho,

Understood. Please disregard this standalone patch.

Regards,
Wenjie


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
