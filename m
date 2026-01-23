Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AAE18D6CFBA
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 23 Jan 2026 04:08:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mzOiUgkbHepYMGTy7uKsCemiXvZYnfaZZU+fNLNeu0A=; b=O/dxmlM1ubAH2ZTsXmctmdffZR
	fpQhZdJO6dqWbJVG9XxfpqVngDpS8FDsfcwGlzVNoA+12MvpY56myFGIGam3GeSZwuDPU0/JgQylx
	auW+sZxa95YZ0UeYw9GAYvPsXngQF7i/ojUJ8oXMxx4uZKFmabBm1BZ3lMBEW5rTpcR0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vj8Ti-0001QQ-CA;
	Fri, 23 Jan 2026 04:08:58 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1vj8Th-0001QJ-5P
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 04:08:57 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HnuopyeK/zzogh7LZV86eWGCaPMH9Zb6v86gfhQXrbI=; b=N4vmg+Y6/R+GqeMlwRAUIQbdgl
 j9Y0yHmxuDYorgi+I5LjI/1sSI1ztYVEsLViRm/EEKgI1djOpgEEqeAm3rdfX+yA+66H+8Esmv87F
 6F1uQWuSQzX4EC3n/aQa0aF0sMGf2s4WXxiTdeP6IdDOLzTkT3ZXmZFkQpGrf0C0ktQ0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HnuopyeK/zzogh7LZV86eWGCaPMH9Zb6v86gfhQXrbI=; b=mcdOSJgVcSG6uIF1Rk/OBb57FN
 SuLhg4ro1LyPPuUdIp6ZhFX9rldiyeUQrmTF2ARmXLUQsxGSpwCI7mN+3+ysAmN8xSlxkLtFiTcb3
 MpIWh2deIoFTY+dDKE4fCMjztSZI9TZTNzlqTmxGkTeWmUkSf3DLqHvnodkyFRQ009wI=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1vj8Tg-000420-Q2 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 23 Jan 2026 04:08:57 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 6CC2E44215;
 Fri, 23 Jan 2026 04:08:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0BA73C4CEF1;
 Fri, 23 Jan 2026 04:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1769141326;
 bh=wlGCSZXy6T9m5mbui6m5dviyE7AZ/Vj5vC2XwFQTI2Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=DETJvzmBRUeGOuScx3ZkzOt2aBqFDDWHrHU5MZpdrP3HqFXAlBT/O1SP9Z5Xmug+q
 oniJ+S3fFVn6o5nhSqKcUFaZf7MeTIqvwefIKEBTFPwg7fQE82tukmUQR++DSaxBga
 nGcUxn91+fas6Tog3dqt/g4wZaNmObsR44C6+weJ7RGUc+5Dmp23V7ukViI3sRmgPt
 WU5ovZrPJ+xEkskmIUCD6aR901iv57WIPP0kIJszBfdzRUs7FzDlJV+4tdvm0V2SDK
 N+IAKZGpBvQDSoudHn9jIShmg9Au1hhPIgkuCUQ6cbdrn4T0MIfYTNi5KpMK2OmXaH
 MqTY9n+F036BQ==
Message-ID: <4964e3f1-019e-43d4-bbd9-a6ba3ba48cda@kernel.org>
Date: Fri, 23 Jan 2026 12:08:45 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Joanne Chang <joannechien@google.com>, Zorro Lang <zlang@kernel.org>,
 fstests@vger.kernel.org
References: <20260123032744.1018230-1-joannechien@google.com>
Content-Language: en-US
In-Reply-To: <20260123032744.1018230-1-joannechien@google.com>
X-Headers-End: 1vj8Tg-000420-Q2
Subject: Re: [f2fs-dev] [PATCH v1] f2fs/015: Test correct mkfs options for
 error cases
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
Cc: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 1/23/2026 11:27 AM, Joanne Chang wrote:
> From: Jaegeuk Kim <jaegeuk@kernel.org>
> 
> Let's add the required mkfs options for quota mount option cases with
> wrong results.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
> Co-developed-by: Joanne Chang <joannechien@google.com>
> Signed-off-by: Joanne Chang <joannechien@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
