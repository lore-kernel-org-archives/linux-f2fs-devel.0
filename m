Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (unknown [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91864C6FD1C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 23 Mar 2023 15:21:54 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pfMlF-0003gc-8H;
	Thu, 23 Mar 2023 15:21:53 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pfMl7-0003gO-V7
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 15:21:46 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=HAGJ8lyLD9nbPVdx2Rxw349fE4HmMkiUxTEWhtRhhpU=; b=jAXAI+FS+DboN+0yMZPmxVzanr
 qubrvIxwfJN8N0+wpKbA8Y7NI0zP76ABM2IiwH28CHXZFz1cd89tgEi8maNHIlAwJ0c+/clgbKsiu
 Nf9verBMg3xa7n+Bh5xGRJD1pUxB0Dc/dpEU+teHdJ9Z2BbGmy6ThPw/TA8V+RqbMjFs=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=HAGJ8lyLD9nbPVdx2Rxw349fE4HmMkiUxTEWhtRhhpU=; b=fQS/PTY9Tus5TR5oPtu5Up/cDS
 ionTfwLHlAh5NRB/VtQnndE8xLYGvMyLdn1EU+XCSMuMPHu2pRpiYXyr9RLSBSfCED+djxd83PK1l
 fg7p5B1BdnJQZyJ1rB8MxQ5is15+5WgV7yGsi9764hiZwlsWVK+JhavHz8kfJqZl4e2c=;
Received: from ams.source.kernel.org ([145.40.68.75])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pfMl4-0007V9-2T for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 23 Mar 2023 15:21:46 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ams.source.kernel.org (Postfix) with ESMTPS id CA635B82168;
 Thu, 23 Mar 2023 15:21:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9560BC433D2;
 Thu, 23 Mar 2023 15:21:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1679584894;
 bh=wDNZypUN3pUlKsoLg7F1xpHMXCzrpFZE6n63BErOVPk=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=rEaAOL6Es2N0HyP3hVvjRdkPuh45Nbw+xFfMk0W3cMJXSerXAJj0pS2yiEGmnDB+5
 GcbP/o97JVVbtmh+jFXZdp5YPjJgmoFCmEpbB9Ltx2xcKfEHfwB91HkIEQ8ziB/A6D
 STY+f+Gyawhntzay8BYIpLuJkEF7Etp6QSX5PSdYEyVpEhmA0PwI1CX0fhqy3XHirG
 4RJf+tIOHv2ri34ugm64K95qcDVpqntGgEao6Kl+84Co0+mSSUtC9kwuD4UsvlcZyP
 DYEfT1DuiaNLtKD4f9CP2qQiLvyoDK/XBoi1byFNimjoAPsMuhW+xU25QXdnVSKTR5
 kbZsRYknhE+sQ==
Message-ID: <90993654-9fff-685e-55a2-8698bc719cf5@kernel.org>
Date: Thu, 23 Mar 2023 23:21:32 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Content-Language: en-US
To: Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
References: <20230302095509.53720-1-frank.li@vivo.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230302095509.53720-1-frank.li@vivo.com>
X-Headers-End: 1pfMl4-0007V9-2T
Subject: Re: [f2fs-dev] [PATCH] f2fs: fix to handle filemap_fdatawrite()
 error in f2fs_ioc_decompress_file/f2fs_ioc_compress_file
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

On 2023/3/2 17:55, Yangtao Li wrote:
> It seems inappropriate that the current logic does not handle
> filemap_fdatawrite() errors, so let's fix it.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
