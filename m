Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FB9FC77B73
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 21 Apr 2023 02:14:02 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ppgHg-0001ag-TS;
	Fri, 21 Apr 2023 02:14:01 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ppgHe-0001aa-Bu
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Apr 2023 02:13:59 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=3qpcZCJ6nC33oWEoeg01lcLZoIoKn9t2P+rg+71dEDI=; b=JJsCSOlvaJ4QJwLgX5f189npBZ
 WzWoPsZOAfrXe1G4bxv6OwNYoRsx1KYpLZVjUzBLLR6LEbaGSjq2PDOSkb6RF+GOeu9339MZp5vzJ
 7V6+V/RR70g5APrrLrAnK9dnUfq/rQxzAm91CpFANBswfRBv/KvcbWvQQXh6vyvkYSF0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Cc:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=3qpcZCJ6nC33oWEoeg01lcLZoIoKn9t2P+rg+71dEDI=; b=RN5m9UpYCxA095mEMY4jRcifoS
 Q/0hDpLpJz6BrbunHUcpnndOgYOavGIbAiLc0a19gVbOWvWW8u0Q4r6R/bmGH+OmxoKrrCr2NLaeK
 wcMIMmqc9B8x3sn46PO0Yl9B2U4cZIvlT32boqhyoCFoTqfTJD3fTbfa6eC/caKxcanc=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ppgHe-00E8Mq-Km for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 21 Apr 2023 02:13:59 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 5FEE763B16
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 21 Apr 2023 02:13:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D98D8C433EF;
 Fri, 21 Apr 2023 02:13:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1682043231;
 bh=GfEnyAq1sJ23EkSIPV78r6qjEZKqFoMaypHu+SvGn38=;
 h=Date:Subject:To:References:From:In-Reply-To:From;
 b=GlW95Jarfr7xQ+vcBeF+RvAOWiaWU11zrAM/eyp15fjn+QnDlVSkF1VoD/1S02+hQ
 usvbYbeUd8174uU0lPXBkbWWKKVjkDhPJUB3Tfoo8yUKJwvWOI/1Fe751BL2SylbTk
 V1DBAIxr062I78XGNVm0Yq4CB2UV776hKxriSNkDYR76zxhiwfCJoWwyW7eO+g89h7
 9Y8KYW9UBHBUDZ3dm8KMXk6IHLrpWPH2MkayZVyOGDDj1P+s32hVNWvxw3hxVOSZ7B
 nTDBo3LKhYu29wpUwQZQ8XZ+qFIeVV5vooGBFEK9y7HfVPvu7Aq2SWv7hlrlcZ6rjS
 UqninEqfRoNqg==
Message-ID: <8e8b620f-f14e-ece3-2fc0-7c14869978ec@kernel.org>
Date: Fri, 21 Apr 2023 10:13:48 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
References: <20230418004049.3262659-1-jaegeuk@kernel.org>
 <ZD69jto/SFPycuHm@google.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <ZD69jto/SFPycuHm@google.com>
X-Headers-End: 1ppgHe-00E8Mq-Km
Subject: Re: [f2fs-dev] [PATCH v2] f2fs: remove power-of-two limitation fo
 zoned device
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/18 23:55, Jaegeuk Kim wrote:
> In f2fs, there's no reason to force po2.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
