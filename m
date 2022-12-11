Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61DD1C4332F
	for <linux-f2fs-devel@archiver.kernel.org>; Sun, 11 Dec 2022 02:00:06 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1p4BdL-00024L-AY;
	Sun, 11 Dec 2022 02:00:03 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1p4BdK-00024F-DW
 for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Dec 2022 02:00:02 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=D4iTN9j3a1TIGkoJzM+rGOaQs5uo/YSTqg+3/eGr12g=; b=hLVogR3ypXVt5Gxiu5aucbPFTJ
 7pAmKVYKNmPhGIjkc6eqAVngcQ2iULRWHzGysgSK+tUVy+e0FhlEWw1zVVNKwM0T0m9y4Mboa7kN5
 X9EuyHJnBnImRw3SruaR02l2IbqfmcS89cO+WFjMRg673CYAo8cQiNhFhOb79BIAoMng=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=D4iTN9j3a1TIGkoJzM+rGOaQs5uo/YSTqg+3/eGr12g=; b=awL2oGD6V7eyJt9oSnh1Vgr/ID
 T9CKHVCemLz2PBOtkCFNY9I2IiQr6gC54qE7Nqdgrbdy2vIcNoDfOJSMC355TuYTJm8lvrf1vwSMx
 n5P9d+ycAjAz8NT6LcZSXVMBwee0la61M3OMrfbfbgZRFeB+e5seEEmRzvbvL2QMoWME=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1p4BdJ-00DQZ8-OZ for linux-f2fs-devel@lists.sourceforge.net;
 Sun, 11 Dec 2022 02:00:02 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 4B4426091F
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 11 Dec 2022 01:59:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D781AC433D2;
 Sun, 11 Dec 2022 01:59:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1670723995;
 bh=+ZFoNDlGEVI3bA7hHuuuTNYqlTyIKalrOF9IEBCd0Uo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=fawb4oMBxb8kDmxe/jO7AT9Xy2rg1DjoRCOUY6hOFKA5scpqL6nA7rgc/FATPOUYz
 mv4947Rw5sZmfSeguKnp10XL6LnOBlbS9yLUwojpDDiwUWUC5vG8U3olGvB+D9yyma
 1Q+IvG5o+UlYv8r0noOD1XRBWOK4aCrSVHPk2VYvcfkmA7qs8e+pSNo7iLAZvqXs1T
 sCoqR2jrkxDLScVMYVL68WSCLCujts/p2Yug2NF+uEw6e2/sqln4fSLugGpczCZkLB
 ncAdkUWbAqjyRpR33ClDJM8DWyofHK7PGl2gehaTubH3nn1InWdBWqpVEzTTYBfUVD
 a8dWGwMppAugA==
Message-ID: <966e1554-9942-97b9-6ea1-5f970119c6a4@kernel.org>
Date: Sun, 11 Dec 2022 09:59:52 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
 <8ffb43dd-3887-aa56-6f0a-1fb6ff0e191e@kernel.org>
 <Y5OPF//DawJbwYgj@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <Y5OPF//DawJbwYgj@google.com>
X-Headers-End: 1p4BdJ-00DQZ8-OZ
Subject: Re: [f2fs-dev] [PATCH 1/6 v2] f2fs: specify extent cache for read
 explicitly
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
Cc: linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2022/12/10 3:40, Jaegeuk Kim wrote:
> Let's descrbie it's read extent cache.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
