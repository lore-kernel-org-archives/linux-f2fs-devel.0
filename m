Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EB90C61D97
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 29 Jan 2023 10:40:00 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pM56O-0007LT-Uu;
	Sun, 29 Jan 2023 10:40:00 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pM56N-0007LG-V8
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 10:39:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Vj9oD18E19ySFG1wVEUQFApCDJ9WyUVQca6xclzWvC4=; b=KXkMo6SK57nkXiAbklprisjtIJ
 L0NnZlcSmZ6fem3SNDBKZTWtbuc8AnKaOIPuL5jsCVgP8kZooCdaNVuCflHp2wWKLJ232WqtaqSFw
 KHECdHL48+gVtRCSzr/fvAmt9CVdc57SAlEWd87IxQEPSDEw7ZNQ7rrxm0GT97fo6c/E=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=Vj9oD18E19ySFG1wVEUQFApCDJ9WyUVQca6xclzWvC4=; b=T5tW1hA6NOKmsb/DUow3bKxh98
 PnzAifAAdueEcUBme9CMKCztfSJpUQjSqBwxXtd1/gtXyIkh1nsYJ7+pCNmq7HLt1y5IQ4ivyMQgl
 gaEcVrGILhDgZbb8C/cH02RSuy0I+7QypEF0bIArOkOF3d936kkncpLYKu+PuUI5jGW8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pM56L-0006wP-Oj for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 29 Jan 2023 10:39:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 2823960CA3;
 Sun, 29 Jan 2023 10:39:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF29C433D2;
 Sun, 29 Jan 2023 10:39:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1674988792;
 bh=U3FzXI5o4oxMN5qdYR1BoL4+SXaR0t0tkbljgs/gJ6s=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=MAlFVNitYdrCahsjEIb9gNkdJuAmd5c5xpx9tYpXfdsQqDn1hHl3UtZfibUZ9t8uV
 n233Jj1GeFQfA9uBa58vxYT4nJXvPvDrcX44nlfshdOVR+Uj5olikWUetctTbNiMo5
 gjmZTGJopiH40K5s5gA4JFAGhN3cBbwio8LauKUQTOGaL2zUM9DkBN4T1N8xHqMye8
 K9jIu7wFMKmmHkSE9AisqcNd7uwqyywkM/nHMSj0dEuCKZ7wmjgmkE9aCCWYQ8md4C
 XGJn6labPnQ78t7IP7SuWlojHn1YKYcvE2uF5YtUKcFqqTzXZV1boW3JFrBIf58Hp2
 OetxN3vqRrygg==
Message-ID: <eb1d37d8-1d60-b885-0ab1-5b1452eabc34@kernel.org>
Date: Sun, 29 Jan 2023 18:39:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20230119063625.466485-1-hch@lst.de>
 <20230119063625.466485-7-hch@lst.de>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230119063625.466485-7-hch@lst.de>
X-Headers-End: 1pM56L-0006wP-Oj
Subject: Re: [f2fs-dev] [PATCH 6/8] f2fs: remove __allocate_new_section
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

On 2023/1/19 14:36, Christoph Hellwig wrote:
> Just fold this trivial wrapper into the only caller.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
