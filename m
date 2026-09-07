Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178D7C79F9E
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  7 Sep 2026 13:03:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-ID:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xizlAgzlYjHXEs3ovIkr0BxhMqpc8I5/pnpKPioqe/0=; b=QA5LsoZqvuoiE/xSoHNuMXakI8
	+UeNs9MQS2a8+4Wf1UiBrfXIWotyFO8XmTkZ2Al/2T4mqleqOYXhsyc115KgBjPUx37xvVmPjzjCM
	rnF9qlDSuhQ5hQ3cJDDGnOD3IKarMCzFQ24ygyAL/f3L7K0ZK+P+9eNsUL6OlPlcfXBU=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1x3Z0U-0002Jv-Re;
	Mon, 07 Sep 2026 13:03:28 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <nzzhao.sigma@gmail.com>) id 1x3Z0T-0002Jn-SR
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:03:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-ID:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=X94qvMDwd78sy0TddN+J3BHx1gatheoLmhmvtOWGjgM=; b=TLv9dIZv2HuBMPOeyRg0mSEPq/
 870qWtDHLxzcms7PhUvcI0Jc42F17Sl2XjLd25ioYcpg+I+L7Vb3EU26t8XlzcY6GxgMjACOw9OlB
 hWQWWbUSt1ru8yvPslchGFFd/2J1U3WrVfo8N9ZTH8M/a+mi+J8PxP1S90ojKOROEQJA=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=X94qvMDwd78sy0TddN+J3BHx1gatheoLmhmvtOWGjgM=; b=meW6xrh2RZAPTPsjptWmIQq4xh
 wYDVKY4hCyNhZ/wB6OyOyNstKXcs8vPAVBxJFnt93E9C7YXfmS4e3TCpUh0l3asBOJvKAlMNeXmxh
 vubrA5QCbfEpkBrh38rHJ0KY1tvJvaQOkBNRMcF+q4jxpbaEex7uu/UE6wfMKaqy2VOU=;
Received: from mail-pj2-f11.google.com ([74.125.227.139])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1x3Z0Q-00053S-2h for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 07 Sep 2026 13:03:27 +0000
Received: by mail-pj2-f11.google.com with SMTP id
 98e67ed59e1d1-398a384b5f7so1961901a91.0
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Mon, 07 Sep 2026 06:03:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1788786200; x=1789391000; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=X94qvMDwd78sy0TddN+J3BHx1gatheoLmhmvtOWGjgM=;
 b=p+ICd7B0dQrVPWUzYefm5IuHT0zBo5ZU8yOkp/PQrZHeo1l3GUoISNpHvmzt42bunh
 +0Pv16cmkeutuM3Vw2B4Qr2weyhR88fw0gwLU2Blvh2bbExdDABPzfoe9eH5adxwBJwa
 sRNRWK4NGq5RMWUK1Fa5f5QXrPafWvAP9zFYZsoNlNQGKeA7wK0M8eADRunxzjiMohFo
 koj3Nt1QPz6NLJtXaXMXU+qtcoaQuQOVNapCLkZ/sKpncqDNs5beMSDZhSt9hEg8vJ/t
 qvemkan8J0nreEMIAn1vIjleMI5ezqWYdIJMSkYCZ+tkcJzGCUA4Q5iycDBtthjKB2bQ
 5C+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1788786200; x=1789391000;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=X94qvMDwd78sy0TddN+J3BHx1gatheoLmhmvtOWGjgM=;
 b=cJ3F4U0XlDBh/ord6osMGt20OswlUQIHgogWvygczrumG2fydksWUs436gYoDpgI8i
 YEZj+cmeqTbI6n8k2wWvlr2CBjmJo1xZ5KYdurfDIToIyBjMddIvN6TsKs5h7c2+BapF
 bh0qWGmtZBK67AipMfZ72NrDSebVvb+xIt+shrTw2VyAT3q1RyKsJfFOFqropFm/+wt9
 a+1BLh1IeDhuFsWNkTUbZ71V/uipF1rLxVIAQ32aub/H2VrzT691ox9pgvZhTD5S2laB
 xg6WG0o+vSqLq81n6RmPl+U90BoJ9ucHV8JDgl6SdJDO2SZbYZ2UB8tjokM5gr4gJB+5
 4Wwg==
X-Gm-Message-State: AFuF++k4A91NkKqIMdzL0UxmuabzBn/yC1+d7dIEDUeMhQyEBYjM+HuG
 xovMeVQ/g36IGm8uFhq2KeANwE5WcTGnIMx7/EJnuuQ35ENStuhr52y8
X-Gm-Gg: AYBFou0+dThoxPdOrPH4vUrBX7gtBmffd6hEuvGx/1teuzkuQ956DnlmKtVjXU/YE4n
 RAcEWNLWqjnah+HeaZI3dSPcIKLN0D9E2jrN+jDv8zgO0R2zlZTtPo47zu36DziJH38HcVSkQKL
 bAQc0DhqW3Ypcl/HKxGQRYtISoyOeKH0m/HHKQWPVXPRDVyIgeMr9h62GsHNHKKwn1/4ZVQXngQ
 jkNG0fc+KcvRceKppTAdiZa69rUM4/nWH3ZyVrQRSUn/dHEtrfQOTtfD3vRjUF3rpkwNi7t7apf
 miBgLg1ZRHD7UkxMo/wVe7LrB4oEJeEmvF+hfYLdRxHeh49UxNJ//ZF8S23dT4rr0tvAJYNr9NN
 OdDpc04SaCLM3D65VZKz8eD0EXn3REM3On2qppai2n/KnX5m0XZXMyGHcdoE8nQU0qso66XFV8W
 luqx+R9ubn8aqdA+V7kl1n7LR3pj+c01WGEGJIjgSqyPr3Car/7+WH/c201a3g07Fm7tjLsy6Q1
 ag7pzpg0S0lBFe4FYELqN64T/qsoPiFO2+h
X-Received: by 2002:a17:90b:1343:b0:38e:9eb2:9d43 with SMTP id
 98e67ed59e1d1-39b261b1bcfmr40426102a91.16.1788786199885; 
 Mon, 07 Sep 2026 06:03:19 -0700 (PDT)
Received: from nzzhao-ThinkCentre-M760t.mioffice.cn ([43.224.245.179])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-39b08cacba5sm28259693a91.12.2026.09.07.06.03.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 07 Sep 2026 06:03:19 -0700 (PDT)
From: Nanzhe Zhao <nzzhao.sigma@gmail.com>
X-Google-Original-From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
To: Chao Yu <chao@kernel.org>
Date: Mon,  7 Sep 2026 21:03:13 +0800
Message-ID: <20260907130313.2626386-1-zhaonanzhe@xiaomi.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
References: <83fe187e-e3e8-4328-bbbf-a6751873b9e0@kernel.org>
MIME-Version: 1.0
X-Headers-End: 1x3Z0Q-00053S-2h
Subject: Re: [f2fs-dev] [PATCH 03/14] f2fs: support regular file buffered
 writes
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Dev Jain <Dev.Jain@arm.com>, linux-kernel@vger.kernel.org,
 David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Jaegeuk Kim <jaegeuk@kernel.org>,
 linux-f2fs-devel@lists.sourceforge.net, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On Thu, 27 Aug 2026 16:56:53 +0800, Chao Yu wrote:
> +	/* Wait for pending drops back to bias which indicates all bio have completed. */
> +	while (READ_ONCE(ffs->read_pages_pending) != 1)
> +		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
>
> Suspect there will be potential performance issue, as timeout interval
> is large.
>
> Looks hacky.

Thanks for the review.

Maybe we can switch this to an event-driven wait instead:

--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ includes
 	#include <linux/fiemap.h>
+	#include <linux/wait_bit.h>	/* wait_var_event_io / wake_up_var */
 	#include <linux/iomap.h>
@@ f2fs_submit_page_read_sync()
-	/* Wait for pending drops back to bias which indicates all bio have completed. */
-	while (READ_ONCE(ffs->read_pages_pending) != 1)
-		f2fs_io_schedule_timeout(DEFAULT_SCHEDULE_TIMEOUT);
+	/* Wait until all bios have completed (pending drops back to our bias). */
+	wait_var_event_io(&ffs->read_pages_pending,
+			  READ_ONCE(ffs->read_pages_pending) == 1);
@@ f2fs_finish_read_bio()
 			ffs->read_pages_pending -= nr_pages;
 			finished = !ffs->read_pages_pending;
 			spin_unlock_irqrestore(&ffs->state_lock, flags);
+
+			/* Wake f2fs_submit_page_read_sync() waiters (if any). */
+			wake_up_var(&ffs->read_pages_pending);
 		}

However, this requires an extra wake_up_var(&ffs->read_pages_pending)
in f2fs_finish_read_bio(). I'm not sure whether adding an extra
wake-up in the completion callback is a good practice - what do you
think?

Thanks,
Nanzhe


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
