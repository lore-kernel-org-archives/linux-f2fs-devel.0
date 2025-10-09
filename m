Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8900CAC5BB
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  9 Oct 2025 02:41:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Type:Content-Transfer-Encoding:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Cc:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Mr6BK2P0421v4nU6x6mOG7zGmwmpJOkwzBrGEKw9Hns=; b=OVkaKl9rBTDwJqYziQ1hVU07/u
	5TUEIs5I/jQ9nbzJLAVaSB9W6jBGGGvCgHN4siDsZg5uLF+httMeJgfgPiIDmC10bnXXR0xm68s9w
	84Bv9YbSpElh7uk8DQ7nhA1JjsVuNwhF5B/e89Vtk1mKCNaqclMeDCqliG6n2PtmW5NU=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1v6gb5-0005br-I4;
	Thu, 09 Oct 2025 02:41:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1v6gb4-0005bl-QF
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Oct 2025 02:41:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=ZqoWb4mhjaUDzGpf8auG9dpMlLQqhGRVpYmMd+oWGj4=; b=KO/zjFxFFyE+Ny1hfzfhKbubDm
 k1FeXgApI1r3h3cM1viY3eB8Wfkkgt1Ne1S6QO/l0ATpXuZlrQjwrZQwCFtI58vJ8Ic5nAJ0CLx6v
 tYOyJ542a6qRSJstZRFdkfy5Kh62Ti1fAqamKKxhXlmoYVxtp18SrZgrBECDZR2TUl00=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=ZqoWb4mhjaUDzGpf8auG9dpMlLQqhGRVpYmMd+oWGj4=; b=fumLz+4TfONjtsqcRJilNSFUrZ
 QJ1tJDPpCphKnBV7z0a084yJjcBqnKOFg100yxrC5t0t5oCq5el349aaPGJkiOCoa5u4KxHQ1BVjI
 IHmykime7MnWAm4pdM0c25Y6AwCtOtDXGF77BcywbIgpGds/5LFcQYm1hN4ZVRthrZBU=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1v6gb4-000499-Ew for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 09 Oct 2025 02:41:38 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by sea.source.kernel.org (Postfix) with ESMTP id 1B15340B77
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu,  9 Oct 2025 02:41:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCEEAC4CEE7;
 Thu,  9 Oct 2025 02:41:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1759977693;
 bh=tyPTsKvXP7E0qtQnoDjMT6ypnIzqmMqIdHBE/yhIktE=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=PcY+hRGuktB/2TcXw6M1LN0anU3ECMMlpKtHmSo3BybrI8rA1vDLnZY35Qb7lUHLs
 rSQrS1NDVUpgq2yjR8/Y4QCzIVnkHgp7PpsOQhUdyt4ypnaxedhJDUKlkxlenRgMX1
 W1WiNMduD/FWAOUseb17VUSlfsxWkQ5X79Xpnq4wgI5TG9U8l62AMbXFjcASscKelY
 Ah5lbeDrBLcE2MlZIOuqvHy+UJsVmLF7sMSV+Iwg9AXjl9lHDsjv4dVE1kgwZj73NQ
 KEyrgpzZE/ZPyE+WB8FNXi5qmVm8ALHR7hkQe2UL7NiBMlnjyWVogEcFswgvwB2Hh5
 Sd6IBr5Nle3qA==
Message-ID: <2d6e8984-9533-46cc-a4d3-875aadef5e5f@kernel.org>
Date: Thu, 9 Oct 2025 10:41:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-f2fs-devel@lists.sourceforge.net
References: <20250930023704.3019074-1-jaegeuk@kernel.org>
 <20250930023704.3019074-4-jaegeuk@kernel.org>
Content-Language: en-US
In-Reply-To: <20250930023704.3019074-4-jaegeuk@kernel.org>
X-Headers-End: 1v6gb4-000499-Ew
Subject: Re: [f2fs-dev] [PATCH 4/5] f2fs_io: add dontcache to measure
 RWF_DONTCACHE speed
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 9/30/2025 10:37 AM, Jaegeuk Kim via Linux-f2fs-devel wrote:
> It only measures the read performance.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
