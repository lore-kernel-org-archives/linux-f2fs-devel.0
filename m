Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 486C8C77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  5 Jun 2023 04:19:12 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q61gS-0002xl-6z;
	Mon, 05 Jun 2023 04:19:08 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q61gR-0002xf-EQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jun 2023 04:19:07 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=TWe2Y7D4E/A7kfly4CSjcUayA/bM8oWxtLdayA3KZ2o=; b=YzKUheNXErQCpdhLwBacYSbZTk
 rp5cV7o1AHMHlot26g9hOruBuSUAaFz+8ukv/6DDPUv7M2T6Ej6SBtRl56BfrFPfMlGrOeVcT/ndl
 ktmRwZpOrglOZN1Va9UeUnwdO13DzT7cvuUraQoNFBWLtaayEjjWcfM68zvu1/CjO26k=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=TWe2Y7D4E/A7kfly4CSjcUayA/bM8oWxtLdayA3KZ2o=; b=f0tqf6mAFb/fROZazRW46xs0ze
 lxP4YWIwDBkLidw05e94njtuCHtZYPFerDiqbUks7Yy52SRuHMK2GcBwSweHjzK9A4+Oy+rCu0tLL
 +xzeWRl5GKxhgHjAV3HhMMkvOsyOf/6h2r2Rf7ASaiyh2yWWet0tPjy0LpaVPYPRHbzI=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q61gR-00BNnx-DY for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 05 Jun 2023 04:19:07 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0666B60C85;
 Mon,  5 Jun 2023 04:19:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7FE3C433D2;
 Mon,  5 Jun 2023 04:19:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1685938741;
 bh=8/RgLxwn3Vbfw/goUIfKuABW9jVshJfGZ9AmaPhNkiw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=VEl/enRRAw+O3XszBhOTu0dIe6T0r2EvH54rU5e8kIDz9lEmOZsempUiWHRkq5yjB
 erqoykBERRZAWlCItMLWQWCEzdcvmQQdsxDtCfDIuAL3/sa9SaesC6MeR7RdEUZErW
 GH+qE6k6ZwlqQRWY9Ze0zzXNDv/wLAv5Dv20KJe9Cj29JJJJraDGkgZBLPQarPuEjV
 gxVKiB1GmuVBnovii2Qlv8N66c0RTM+Y1/yJt2WVuBrpP+JOYWdP2LPrt4Ok7RUcKl
 1NhYFI2Mnu5Q9y1/L9nLMMgHubzGJ/a2ls2WNvmhRUOj9XutWfTAviUw5qQEjXLYdh
 w47gjENo1P/Kw==
Message-ID: <6d606656-b1ce-2bdd-04e4-f66b466419c4@kernel.org>
Date: Mon, 5 Jun 2023 12:18:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Maxim Korotkov <korotkov.maxim.s@gmail.com>
References: <20230602102451.602105-1-korotkov.maxim.s@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230602102451.602105-1-korotkov.maxim.s@gmail.com>
X-Headers-End: 1q61gR-00BNnx-DY
Subject: Re: [f2fs-dev] [PATCH v2] fsck.f2fs: fix memleak in f2fs_create()
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
Cc: linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/2 18:24, Maxim Korotkov wrote:
> In error handling cases, the function exited without releasing memory
> 
> Signed-off-by: Maxim Korotkov <korotkov.maxim.s@gmail.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
