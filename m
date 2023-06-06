Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 682DCC7EE23
	for <linux-f2fs-devel@archiver.kernel.org>; Tue,  6 Jun 2023 01:04:33 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1q6L7d-0002YR-Do;
	Tue, 06 Jun 2023 01:04:30 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1q6L7c-0002YL-PQ
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 01:04:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=02VuODDauoH+xWwWqqVlfL2InWuXV7S09fd24l8sJVQ=; b=haAXXNcR8qyuRfVa1kV3uS4yDT
 sBtbeHQ74ANkl+C4VVqqn9iA6CGrMuJDm33Iv+TBevQl16brR0lWOUuw7v8zOy7ce2mKQozoHtrjX
 6gw1pH2Wqxgb7uMWqr6WpWm8Odm3RRvNeY9A2+KvxyR9o2bMuk1FK1TtJDE8zpAXtHxA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=02VuODDauoH+xWwWqqVlfL2InWuXV7S09fd24l8sJVQ=; b=Ufqa+gYYdvmHFk7eNTLr9GIWqt
 ewCLRR+Fv3DqF4KfI5/7Bosmkt5jA842aUcoeaTr5Rb3Er6Ln1J72jrHz4wI2ExrYWCSOEna3Cro6
 URURQX45E9te3zF/iHM3JZfP6arM11hPPU4WJ5i5QF/4zrbCsnlIrwzRTe4lt9iAG7Jw=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1q6L7Y-00CIhn-Pi for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 06 Jun 2023 01:04:29 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6014C6205F;
 Tue,  6 Jun 2023 01:04:19 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A872BC433EF;
 Tue,  6 Jun 2023 01:04:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1686013458;
 bh=r3Gwz3uXuL11j2qCuQ3fB6IOkg5vQV9Hv0Qe6Pfl7W8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=vNtMq2mjj96fX8Po7xrYRi7yWOG2vBfijGSFP62ba+Do9QRUm+aHAkp0vitsFuD4n
 mSTCZvbBg5edjlH89OXNjDKM1a0Hy0KhjcKKS8/LiM+zQDVe+OhbrCu+FkeS3gDlVa
 yEgPZVBd+Gg8V0v3wZJg5l6VCB5CyWRUOFrhglIdUF2hCedBCS25yW40JmZS48jix+
 f7KzKfiMMx/KaJcUXLdd3p9XZZseaJJHMi6Eycdd4fM1PIDaFDkXJYgPymYoC1KJn3
 txN4FqcctBrY+S19GDjB7Tifc5I+OalIlDTegoKOoxvcvW/IpdWMsH7O+3uZIQTMen
 AKHgzyIGu1CjA==
Message-ID: <c71460d5-5d4a-e614-ddd5-3f708fd01011@kernel.org>
Date: Tue, 6 Jun 2023 09:04:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20230531175214.3561692-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230531175214.3561692-1-daeho43@gmail.com>
X-Headers-End: 1q6L7Y-00CIhn-Pi
Subject: Re: [f2fs-dev] [PATCH] f2fs-tools: remove power-of-two limitation
 of zoned device
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/6/1 1:52, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Remove power-of-two limitation for zoned device, since zoned devices
> don't have it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
