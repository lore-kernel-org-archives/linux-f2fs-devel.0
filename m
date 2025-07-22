Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A5BFEC83F1A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 22 Jul 2025 03:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=jD/TPxIzdYr3RRVKA4jEylNAf6eCWgd45jHy9fT6CeA=; b=VpHnUiwOWt/ECyxhIpazDk/0gY
	MReJ0A8TfCPt0ZYiCfu2XnwuTVMrxXGR7Io7FD97TmWqZKU/5UKWxEOWrgw5YJazp+BHQBiatiy4q
	4wDK/tKZOK1F1RkbssPCArqf5QgYVgSjnhih/Dzrngj06UpUiBWeCqaD/6fgJld2CZ0U=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1ue3w6-0006pO-SX;
	Tue, 22 Jul 2025 03:45:02 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1ue3w5-0006od-OX
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Jul 2025 03:45:01 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=CujeXEhqz51JYz3KPw9WEBL/XCz9YdOn0IkZINU59cQ=; b=Jkf6jvRmPhQsqSsYq+lKftr4Mg
 qjOreYHeO4bMUy6Qgy6HeNI2Qpos+Tm4k7uOICnUVkuBGFSNjNbosEKq82CB7gWTABN51FCItj2Qn
 hRpwvspmtEtIjmvt4Amg0Khl8hj5g/JTvVhV2VCHwZZPfTDvpvU5Q+7vqCi8bf2rXDB0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=CujeXEhqz51JYz3KPw9WEBL/XCz9YdOn0IkZINU59cQ=; b=b9yxCwXEoH6LRrohiZoa2yu5fR
 bdgvMm/ltMQCJRp1C1VevhDyNY7LQziUBYM2R4FISnfma46ngHGhaPHWXMNbPichf129M2DPODsqJ
 NK33m4EdqoFgxqaGUU5I61M+8YbbH2YRzRHwWXVfeIDwYiKhbz3OWDw6XVlAj3WmxULU=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1ue3w5-0005q6-Ad for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 22 Jul 2025 03:45:01 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id A6195600AD;
 Tue, 22 Jul 2025 03:44:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4799EC4CEEB;
 Tue, 22 Jul 2025 03:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1753155895;
 bh=HBkvK2FIkycCsMyaes5P4qpPldkypymFszhWbmSnX0w=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=P8KfzNjsYTU9/id93cDjW6sEdBAqd4fcwfdU9IJ7QsnJJmrToBjEWdLER0DeGzwGb
 CDWPqQ5ltdBgEsIP7p1uYIYYoud/MS07zlEAkwVePnTmW0pVHEf7v1Xe9AX8fclNCa
 HDHJnEezyEXq0dfQCaxB7wzik4yhdokLl4OqmIKMmBjoCZyvrq0O4Hc/8WDW0ahpIG
 NJ1D7CJrt4n2/VFMX7Qk7Ts+xyVbdActSh8JTiXM6PGCp3uU+uc981QBq4msYWnGKt
 bgCX1802bdS9t2y/9zrD+MU8tdBLaYiRsAqUjiza5OcwfSiUSlsAvjABiCyx4E+yh3
 e0sgZHEG1W5YA==
Message-ID: <7a424039-8182-40a5-bc8b-0f04118ef0c6@kernel.org>
Date: Tue, 22 Jul 2025 11:44:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20250718220431.2290301-1-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20250718220431.2290301-1-daeho43@gmail.com>
X-Headers-End: 1ue3w5-0005q6-Ad
Subject: Re: [f2fs-dev] [PATCH] f2fs: ignore valid ratio when free section
 count is low
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 7/19/25 06:04, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> Otherwise F2FS will not do GC in background in low free section.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
