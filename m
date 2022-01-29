Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1BDA4C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Sat, 29 Jan 2022 06:30:36 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.94.2)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1nDhFr-0004QV-V7; Sat, 29 Jan 2022 06:30:34 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.94.2)
 (envelope-from <chao@kernel.org>) id 1nDhFp-0004QA-5V
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jan 2022 06:30:31 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D/BRcPjDz8FyX6KbJU2aaTn+6qGQwD22THOzvfkiQ8M=; b=U3JQlO5hfz5Ga7bSF7BBFSWiW4
 KxK4caCXZJLMYH+DSapVCG+Edx4Op+ZZssMzMg5RLMT0WXQvfCeyzuODaAqkds2BXYlMPLxjII09v
 pBuUQvwch8zi3ID5vpLk552NxP515GYcaWxjSl+KdYnmVvSwHcfGXHXNykmAx39isdGM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D/BRcPjDz8FyX6KbJU2aaTn+6qGQwD22THOzvfkiQ8M=; b=PbeqzGcjk0/dTb5PIo9tzZMaxa
 vZFHeBbPCc41H+TlAPoLsB62+B5+jcZdZdyv+KY6gnqm1Drc19BoxpBcXQV9pNxNErqofBgfSa6ng
 dUKFkiAoliQCDogW9SE5QtzX8eTrYrCRq5bvjn3uXlMveaqS6WcQsNpl/kKrmEL1iHY0=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.94.2)
 id 1nDhFh-0003lT-MQ
 for linux-f2fs-devel@lists.sourceforge.net; Sat, 29 Jan 2022 06:30:31 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 6CB8960B89;
 Sat, 29 Jan 2022 06:30:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD284C340E5;
 Sat, 29 Jan 2022 06:30:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1643437814;
 bh=O0Vb2Z47aKXoGYrt0vsVOneHYCWi7TwmdD7NQmLIbLE=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z9mXvmN2zDZN233yVb0WPcheCr+3xRNokZOrPgIjzkQiSf0pj3skbNdyoQ/y35QPS
 5VC1R4u3GTonsBulJJXy3UlanxC5zFTYJDFQwlq1AWa9zCh35UNSJ+zmN4NWR4KHj9
 4MDk+s1TsAfKnzoH2Riw6JV1v4pWdZPNzMX1WHM3aB7KK5OtfX4pRbqZ+ViqcowUnN
 xixIjHPXtVWu59AHoGkmLjeNn9kvdupUp4yCw/TtdtlCx99SZLGpSPo0Hif1UMKWND
 aIqxo6XOauWoJE/PglpdVRfdtZmSoHL6UykybTNnMnRr/wgGZuI195CZx5RBdxM8Hk
 O6PMV21WZv1kg==
Message-ID: <31cc6a64-1962-d336-601f-70f3f8e7bf29@kernel.org>
Date: Sat, 29 Jan 2022 14:30:11 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20220125202254.3111474-1-jaegeuk@kernel.org>
 <20220125202254.3111474-2-jaegeuk@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20220125202254.3111474-2-jaegeuk@kernel.org>
X-Headers-End: 1nDhFh-0003lT-MQ
Subject: Re: [f2fs-dev] [PATCH 2/2] f2fs: expose discard related parameters
 in sysfs
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
Cc: Konstantin Vyshetsky <vkon@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/1/26 4:22, Jaegeuk Kim wrote:
> From: Konstantin Vyshetsky <vkon@google.com>
> 
> This patch exposes max_discard_request, min_discard_issue_time,
> mid_discard_issue_time, and max_discard_issue_time in sysfs. This will
> allow the user to fine tune discard operations.
> 
> Signed-off-by: Konstantin Vyshetsky <vkon@google.com>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
