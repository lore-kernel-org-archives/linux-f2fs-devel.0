Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 44121EE01FB
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Sep 2024 02:13:34 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1soCrN-0003fr-UK;
	Wed, 11 Sep 2024 02:13:33 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1soCrM-0003fk-Kr
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:13:32 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=EYa2Dzk/rSA6fuQHG/TKU8BNouAFf7bGHmEiXnz0OzM=; b=Qep/BcsqE57j7s9l9hKVVSFe7s
 Nhw8YNMfYu5fh4svGWEKCChQYfozlncmJAFURhIjwWTHY8pAid9dPeoia3MBrbcHMixU9wdHGqN9C
 3nGIYIxJyaKCwg6fBks1PAi2Ug0c4jyL7bDWKzBPmaycOyrqzK6vN4+9Q8r8kLuuwIEY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=EYa2Dzk/rSA6fuQHG/TKU8BNouAFf7bGHmEiXnz0OzM=; b=Oqtw60Gs1f3Qfqs/YxcrMRCW9/
 M6AxnkoDhiS5VyPdp/MlztbR0L9OxLe8KPRFgVIZXAIe4eTtFWTWDF59Xlu7U/M/OXx1NO46CjIS1
 MY9dBYRjUM9uA+4Ewoab6vDXGkpIiMYxFPvirxzXmhUBB8CuntWymn+9kX7LPQqP2lYo=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1soCrM-00050E-20 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Sep 2024 02:13:32 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 2F7AF5C063C;
 Wed, 11 Sep 2024 02:13:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D355BC4CEC3;
 Wed, 11 Sep 2024 02:13:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1726020801;
 bh=7C330WHM1h3otPTiJzP6prlQsfXkoroqppbhylWrFKQ=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=drH/MAEeUkyvj67TxLA0XKDvm3rj/9gLNAfOHw2fhY3l1gBmnIFh5mufh3QWqXz9W
 AXivJMfvGheKuS3fn+yEWsUdwr5sDwrohm55nJy7h0SrR5j9+FrcrZ4YRnU57s5Uhq
 Qed+nxSxEb1JFeZcSuon/nq3tDCpl24zhZ1OEDjc+1UbwEg33PuX3CDSeq1gP4zCRo
 RTnBncXxz81H+K91qL4cTEj2R0uIzTyP4jD8tLjaAKI5jmm1kr1wK54I28CVA8gXhy
 67WNXYIcSiPAgAgZTlf9lXkQZY+4IUChSGGH3tpW7Hn/BmgXbKBeUrm4gihvaNx9QM
 4tv2VJbMsqvvQ==
Message-ID: <981bde27-ffa8-4021-9766-e4db877aae38@kernel.org>
Date: Wed, 11 Sep 2024 10:13:16 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20240909221946.2004046-1-daeho43@gmail.com>
 <20240909221946.2004046-7-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20240909221946.2004046-7-daeho43@gmail.com>
X-Headers-End: 1soCrM-00050E-20
Subject: Re: [f2fs-dev] [PATCH v2 7/7] f2fs: add valid block ratio not to do
 excessive GC for one time GC
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2024/9/10 6:19, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> We need to introduce a valid block ratio threshold not to trigger
> excessive GC for zoned deivces. The initial value of it is 95%. So, F2FS
> will stop the thread from intiating GC for sections having valid blocks
> exceeding the ratio.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
