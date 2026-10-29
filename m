Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4579D606A31A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:31:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=j0dHbHLo;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=X9e/YrXG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=lORfmJIR;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nwNXv2Aw
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=fB7KlSWVJKqhDQ3B8j66SARBLaO3304Wfk4C1/qirGA=; b=j0dHbHLoZRhP6J
	lvhEew/vRVMTDGY3KXeJlpqKaiHLusI1pPfpVPVsgpPitKx08Y0mz0XF1EmsDM8xO7jWFPZwCpgEu
	qL5/eMsmHfiaQdZ03W+rBnjQXlCcbRnVezSiLJZ06StdUK5GxMRwyDouvhDmLSPgiP/lE4+NdlAKi
	JXQ=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMEzW-000000004GB-43ka;
	Thu, 29 Oct 2026 01:31:42 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMEzV-000000004Fv-1vZA
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:41 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzvyD1MWwWcM2D8fVR9Ay/l11ugYd2Yxj3Xl2WNQqh0=; b=X9e/YrXG6hlVOODYwsf8xWKGfw
 aGqcMtvAJhfKJg8DeWFDUhZ/QowjDlzO7FS5lkISbL9SGnm77LJ4y/LvJBJo1X5OdB8YWbIC6QJry
 mbeCNU2PWHZHEM6FxSFvX3CRMM7dgh3Y/IR7mnAIK2vJihVZ6WzpCDN0fpNjqJipkGeQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=QzvyD1MWwWcM2D8fVR9Ay/l11ugYd2Yxj3Xl2WNQqh0=; b=lORfmJIRYaoH4XXzZKjLlP88SD
 KY01K1bZDIdMMc3X5YuCHqCgyWooi2nrTte6Fez37mRnlonJtqTirz+G9ASg7eb9w9zSTo2a+9JDr
 Jvae4kFg1k7o4HY7OyP+ej+pEldcm3HJUji+5C89UTLb4W0bLaJIEDVzzHGiydM2gqQU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMEzS-000000001Vl-3fP0
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:41 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 8342043261;
 Thu, 29 Oct 2026 01:31:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5E71F01825;
 Thu, 29 Oct 2026 01:31:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237493;
 bh=QzvyD1MWwWcM2D8fVR9Ay/l11ugYd2Yxj3Xl2WNQqh0=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=nwNXv2AwDdbRNxgOxIfQyQWuDY26T9x0FUi3X+Mo2Ij2NJe8itQw+LXcAYJGCL+ez
 jXR8RsLUn2ZawimSuV+KnA4Ze/Te2+pm//cB6X0Uloliy79Me+LhpCES9pFPbL39ba
 ciMiPWcZ3MXiDz/KzFii302RYJuesDXwZ4HZfgY0J2Aa5QtYU870FUJSYyTry3P58n
 0b3QycGtokkQEauUoyhD5RKXeSy5g3c3kzaeMZSaAKdZIXjnRAc5Rb/oDA7k7bUGIC
 AAp1HQTO28tn3NzxjK1l//GrcltLB8n/2qMctkqDpXlhDRRmlRMaVH/200Nd8A9CNS
 xbXUpJ69lSLnw==
Message-ID: <5a644470-f8db-4de6-96bc-becda4dad88f@kernel.org>
Date: Thu, 29 Oct 2026 09:31:29 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-4-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-4-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMEzS-000000001Vl-3fP0
Subject: Re: [f2fs-dev] [PATCH v8 03/15] f2fs: support regular file buffered
 writes on large folios
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
From: Chao Yu via Linux-f2fs-devel <linux-f2fs-devel@lists.sourceforge.net>
Reply-To: Chao Yu <chao@kernel.org>
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> To avoid the complexity of unlocking a large folio in write_begin,
> preallocate partial blocks for inodes that can use large folios.
> During write_begin, read only the partial head and tail 4K subpages
> that need read-before-write, and skip read I/O for the full middle
> subpages covered by the write.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
