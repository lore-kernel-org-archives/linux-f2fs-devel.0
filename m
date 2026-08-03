Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0B761C55184
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  3 Aug 2026 07:36:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:Message-Id:Date:To:From:Sender:Reply-To:Content-ID:
	Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
	:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TP1CHIktc3dKxA3mndZNKDVal6/Ol5rrnJ02VCD6quc=; b=NTKdzDFN4n+ISu7FRoo9FnRUmt
	2k7vDnLhtYZVHffOceV3j4qmMC8TMkZZ1pnc6O8hsSYby4rBalNLMqHHjECXxU+YKBcBE+TAe7nEF
	YSgHNIiSjJUP5T+rIYIuOxddHseXXN9/+sImdZ5bdbuj4GRtrm1nTkqlWmIomZzgNTfc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1wqnE9-0007Lk-Se;
	Mon, 03 Aug 2026 07:36:47 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chenchangcheng@kylinos.cn>) id 1wqnE6-0007Lb-Ty
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:36:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=+jGUM7lcMx7m3evdq3lzbuH0rZ/QXA3zY3GiS5gBjLc=; b=YwJerjNBoFMGko9Ci76LAdfSzi
 EPZPZhxl87f5R4hX6zfFX52sVfFRCawubsgR9NfUe5bF+tsXaKwaydhdHGZDCuzYH1G71VFERe6X0
 Tpg7/1PmKkVKGlhbl7IkxlaJuJ5csW0ZV+9pewgxvzyOl1hr32NsKW0N4DesBywVDdrw=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From
 :Sender:Reply-To:Content-Type:Content-ID:Content-Description:Resent-Date:
 Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:
 References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:List-Post:
 List-Owner:List-Archive; bh=+jGUM7lcMx7m3evdq3lzbuH0rZ/QXA3zY3GiS5gBjLc=; b=A
 DKlNdW4Tqw9189T7kQFYMt5vv9wD2PeuxH9JZOIEuHa5KlEEwd1tNKL/9N9FLSsTqeXjb71StjTL/
 HBHeFBpISiarTYJ/Af1BL9vpQRbJblst5yiTnysPzpteUzjMHC0gcVO0Luq5ggvE7F+BsSeCaTUOz
 ZDB0CD3Su5tBK1lc=;
Received: from mailgw.kylinos.cn ([124.126.103.232])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1wqnE2-0006nW-Q2 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 03 Aug 2026 07:36:44 +0000
X-UUID: 09adb2f68f0e11f1aa26b74ffac11d73-20260803
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.12, REQID:02a7c318-071e-4dcb-b611-fe8ad65278dd, IP:0,
 U
 RL:0,TC:0,Content:-5,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTIO
 N:release,TS:20
X-CID-META: VersionHash:e7bac3a, CLOUDID:dad0b878ae4256c8ba312a05b0d29186,
 BulkI
 D:nil,BulkQuantity:0,Recheck:0,SF:83|102|136|850|865|898,TC:nil,Content:0|
 15|50,EDM:5,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI
 :0,OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: 09adb2f68f0e11f1aa26b74ffac11d73-20260803
X-User: chenchangcheng@kylinos.cn
Received: from localhost.localdomain [(10.44.16.150)] by mailgw.kylinos.cn
 (envelope-from <chenchangcheng@kylinos.cn>)
 (Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
 with ESMTP id 40099072; Mon, 03 Aug 2026 15:36:27 +0800
From: Chen Changcheng <chenchangcheng@kylinos.cn>
To: chao@kernel.org
Date: Mon,  3 Aug 2026 15:36:25 +0800
Message-Id: <20260803073625.218507-1-chenchangcheng@kylinos.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
X-Headers-End: 1wqnE2-0006nW-Q2
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix valid block count leak on data
 block allocation failure
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
Cc: jaegeuk@kernel.org, linux-f2fs-devel@lists.sourceforge.net,
 ccc194101@163.com, linux-kernel@vger.kernel.org, chenchangcheng@kylinos.cn
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

Hi Chao,

> Needs fixes and Cc stable line?
> 
> Reviewed-by: Chao Yu <chao@kernel.org>

Thank you for the review. Yes, I'll add both Fixes and Cc stable tags
and send a v2 shortly.

Thanks
Chen


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
