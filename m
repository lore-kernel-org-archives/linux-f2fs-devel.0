Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EECDC35274
	for <linux-f2fs-devel@archiver.kernel.org>; Mon, 18 Dec 2023 09:52:03 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1rFAI6-0005KR-QT;
	Mon, 18 Dec 2023 09:52:02 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <dlemoal@kernel.org>) id 1rFAI2-0005K9-Rp
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Dec 2023 09:51:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=UXzapRBF0XP9dqhOwn1urD+qb34Omrr0zBsGvVTpYtU=; b=G5MfoNCMfjoDWW5Uc/+x1TmRdV
 Xmj8/t7V1z/IjHuGXCxRvJtwhxfDEn8pO69Iv4mHZVi6zNiOnb1Zr+UJSpm2jYNDWfP220IG0OM1n
 Al8NhUKLJu2zEQIAhBOtYLPKrPIIvBUHX+g/VOkZmVEE0Q4CDteGFxIRMJUJkPDsHtOA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=UXzapRBF0XP9dqhOwn1urD+qb34Omrr0zBsGvVTpYtU=; b=iUF1n802hik12eeKSp+HWTG+4b
 P0mrz5JIGOJCPusspS0rwj5NglWjMBmY+p0jdZS2eQtcl5midn3JtKjdFxhmrPhJ3F4nCiyC174zu
 Hs5t9FlGl4r+Q8JmruShQpgt6JL3UcgTJuAj7lMCgvdr7jlUPBDfG7OYKL/dsJ3hiGuQ=;
Received: from sin.source.kernel.org ([145.40.73.55])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1rFAI2-0005EE-4d for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 18 Dec 2023 09:51:58 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sin.source.kernel.org (Postfix) with ESMTP id 4E663CE0FD5;
 Mon, 18 Dec 2023 09:51:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BECF6C433C8;
 Mon, 18 Dec 2023 09:51:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1702893102;
 bh=0ltLchd8OdyqGdbUKNCnj2CSZ8BI8m8JXNh7/DpT4q4=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=BxCsjQnuJnhh0O1R4P1jparwYYvwuJzUuts6R9qqR4wY0ZeR5eIdS4bVLOC3EMYJJ
 BoNRgH9yCu1zFqd3LLzgK0zPtMOLNLbFZHNMmde2Pk9uWDlZcyYUwWCoGkWamIj7z+
 6rpUoxGi/7Dezk78J9tb+fqCtwrVgkcgKlv4uAYpoF3EewrSfEDGhTfzhUFIDrJCpj
 /rkjWbHMaVlrNZ0o5NVjhXyj6Av1WNDiETUSkftHjyCb/1JHmJmwomRMHYhW23/dPF
 a6basN5WJgoh0KWx5ED+pMlx2XZ+osDMzmdwFSeSiaUlHW4oCGvwgJVT6ls7VRD6tS
 +zPJRqAvMhajw==
Message-ID: <572219b1-c528-475f-9219-8027a3790563@kernel.org>
Date: Mon, 18 Dec 2023 18:51:40 +0900
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>
References: <20231217165359.604246-1-hch@lst.de>
 <20231217165359.604246-6-hch@lst.de>
From: Damien Le Moal <dlemoal@kernel.org>
Organization: Western Digital Research
In-Reply-To: <20231217165359.604246-6-hch@lst.de>
X-Headers-End: 1rFAI2-0005EE-4d
Subject: Re: [f2fs-dev] [PATCH 5/5] sd: only call disk_clear_zoned when
 needed
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
Cc: dm-devel@lists.linux.dev, linux-scsi@vger.kernel.org,
 "Martin K. Petersen" <martin.petersen@oracle.com>,
 virtualization@lists.linux.dev, linux-nvme@lists.infradead.org,
 linux-kernel@vger.kernel.org, Stefan Hajnoczi <stefanha@redhat.com>,
 Paolo Bonzini <pbonzini@redhat.com>, linux-f2fs-devel@lists.sourceforge.net,
 linux-btrfs@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/12/18 1:53, Christoph Hellwig wrote:
> disk_clear_zoned only needs to be called when a device reported zone
> managed mode first and we clear it.  Add a check so that disk_clear_zoned
> isn't called on devices that were never zoned.
> 
> This avoids a fairly expensive queue freezing when revalidating
> conventional devices.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good.

Reviewed-by: Damien Le Moal <dlemoal@kernel.org>


-- 
Damien Le Moal
Western Digital Research



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
