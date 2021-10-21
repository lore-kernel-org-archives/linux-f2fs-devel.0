Return-Path: <SRS0=vPj+=PJ=lists.sourceforge.net=linux-f2fs-devel-bounces@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5B21C433F5
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 21 Oct 2021 11:29:48 +0000 (UTC)
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id A85C960C4D;
	Thu, 21 Oct 2021 11:29:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org A85C960C4D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=lists.sourceforge.net
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.92.3)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1mdWGZ-0006Sk-A0; Thu, 21 Oct 2021 11:29:47 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 (envelope-from <chao@kernel.org>) id 1mdWGX-0006SY-8N
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Oct 2021 11:29:45 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=lxmdV0DbwuI/GlDa8XyPLQCRvSJQIuOek84CVUR0x8Y=; b=aAl6ZGe+W3lScBJtVI2A9ete/A
 QKWH/EhZqjxlGCGyxwUqKUzKVUZPjTVL56f52bxpCwqjNr2Hde0khM6ZQ2ShwTmMxkMZsDyzzM/rn
 GDl9vaGV2MmgnW75OgeoU4INxCKiqE/s6rXkVM+RK09ljPB1MXLqvRvC5sjG3tAHro/w=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=lxmdV0DbwuI/GlDa8XyPLQCRvSJQIuOek84CVUR0x8Y=; b=CJoAupqYLgdn4lkqKxj8Q93p/K
 DyHMUzniJVCTAK2gQzV3RNmpNBHZZAC7y4kxKInxecc1La4YS1PQ8e/T/etfHIziYUHOZRUz2vAn0
 XQDUkwTguxn1HnqYd/D4YWwcBdywCC3Zr0uAwGvfhRhqUX1MbVkWAFrOab57l4axfOxc=;
Received: from mail.kernel.org ([198.145.29.99])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLSv1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.92.3)
 id 1mdWGW-0007oU-Ms
 for linux-f2fs-devel@lists.sourceforge.net; Thu, 21 Oct 2021 11:29:45 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id C2E8960EFE;
 Thu, 21 Oct 2021 11:29:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1634815776;
 bh=mcc72ZcqDdMDWiL2WxtN09zO3LW9PCTKiI0ho3RGf3k=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=AIGa8F4hEJ9tysD3zEuLrV/8EzNpzbOIYGrO0kBy4fh+xFqC4Pxeg8KwwwPkTyGFG
 /SiGt8Rlaw5iZsW9mNKPUeHchALKfHAVmss2slYOu1KAqMe6FxpA/33Im/4+nuee6D
 8EqYO+OmQUjMh7HCdZIJlNwqti6cc/WiC8eDgUuY+IlW8aqG4yT56LAfPeAi8O2QBc
 ajy60KmOnmJg43C0hj1ZhjK7KhTTgdRkUVuDjQt6e3+/wb6NgSqjCOjkMbeKCq8AKG
 rnj0YTE6R1EVI6dR0x9Mwib6f+ll4L6r61B4amIKRc5/RY8pdxg/j5+XYAcsdaQvyb
 vyaUVlm4J4Rng==
Message-ID: <0e77ea3e-196e-cc41-91eb-abc89ca6d522@kernel.org>
Date: Thu, 21 Oct 2021 19:29:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.2.0
Content-Language: en-US
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20210929181203.1606675-1-daeho43@gmail.com>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20210929181203.1606675-1-daeho43@gmail.com>
X-Headers-End: 1mdWGW-0007oU-Ms
Subject: Re: [f2fs-dev] [PATCH v5] f2fs: introduce fragment allocation mode
 mount option
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
Cc: Daeho Jeong <daehojeong@google.com>
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2021/9/30 2:12, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Added two options into "mode=" mount option to make it possible for
> developers to simulate filesystem fragmentation/after-GC situation
> itself. The developers use these modes to understand filesystem
> fragmentation/after-GC condition well, and eventually get some
> insights to handle them better.
> 
> "fragment:segment": f2fs allocates a new segment in ramdom position.
> 		With this, we can simulate the after-GC condition.
> "fragment:block" : We can scatter block allocation with
> 		"max_fragment_chunk" and "max_fragment_hole" sysfs
> 		nodes. f2fs will allocate 1..<max_fragment_chunk>
> 		blocks in a chunk and make a hole in the length of
> 		1..<max_fragment_hole> by turns	in a newly allocated
> 		free segment. Plus, this mode implicitly enables
> 		"fragment:segment" option for more randomness.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
