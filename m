Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2E169C7619A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu,  6 Apr 2023 01:53:53 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1pkEoy-0008Hz-GI;
	Thu, 06 Apr 2023 01:53:51 +0000
Received: from [172.30.20.202] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1pkEow-0008Ht-Vs
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 01:53:50 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=KubOvEHPLUbGRWIGZmAopSkuGwraHpcciJzVaq+gzkQ=; b=Um3H1pRi1XDUjnfPwhGUAhGG6x
 2jvMNwElkKyL2SRhi+vdv4GHW5an5ZTAoSd1CZPEyfrPsmWCvbELLX7A2lkK2Yaj1cVq07tPF5N4s
 fFn0BcAhycN945ab0Pkb12aoIJMr1utoURXvubJ/gsDjCPNkR+HIHikQsU4LFycnvDHM=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:Cc:To:
 Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=KubOvEHPLUbGRWIGZmAopSkuGwraHpcciJzVaq+gzkQ=; b=bkdxikL+qDPybyB8grJxE7kv4F
 5iflwEVnJFWx0i6FhurWHfZqsj76Wdi0SwYIxF55NhmPm3xZD90pimXmuZcQELCoT8GV/NneSYBIj
 xIRtH7o4ijeizskDftC4zykr4YkZYVwHdOePoRhz/eoH+VMh4t+3Miht79Fes5cmfQ1w=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1pkEou-0001wJ-Cf for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 06 Apr 2023 01:53:48 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by dfw.source.kernel.org (Postfix) with ESMTPS id 0221A61202;
 Thu,  6 Apr 2023 01:53:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65538C433EF;
 Thu,  6 Apr 2023 01:53:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1680746022;
 bh=RU0Q3vUCSoOriMTSmQ2CiAo6okbHQsDApEtyfqhB/os=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=FbWqGQ0wbGurzrP9KVHM0SNw0YC9GyWApFTXwdNVcK2A0TiZtlGaba89nxCOMrOnv
 LWjeD76eOESSoHb3bjdBWreXKq9o6hYFzR7svS/T2cmmEB82GOCY4PQ4xwOErbFzpU
 hmcAghCKLKqbx4A0blihXUGzlq7+9VmymPLp1sU/9GKwTNgaMazWLz2aF2o38rqb3J
 b3LRiP0wTjMiqcG9t360E1ofmIBaOFnuhJb3uzgevc579iZR/wnVuIvdPxErd0uHqj
 plvf4gfX7jEtsbHb5zbnA4A6/Ie41UsiXOM4Khj5aTYqCMkOCJ9lIg3iiItz27lqAh
 KTIvUAvOE5HOQ==
Message-ID: <b0214d14-aa0e-f1df-4ff3-02304b710a6e@kernel.org>
Date: Thu, 6 Apr 2023 09:53:36 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Content-Language: en-US
To: Zorro Lang <zlang@kernel.org>, fstests@vger.kernel.org
References: <20230404171411.699655-1-zlang@kernel.org>
 <20230404171411.699655-4-zlang@kernel.org>
From: Chao Yu <chao@kernel.org>
In-Reply-To: <20230404171411.699655-4-zlang@kernel.org>
X-Headers-End: 1pkEou-0001wJ-Cf
Subject: Re: [f2fs-dev] [PATCH 3/5] fstests/MAINTAINERS: add supported
 mailing list
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
Cc: linux-cifs@vger.kernel.org, brauner@kernel.org, linux-ext4@vger.kernel.org,
 ebiggers@google.com, djwong@kernel.org, amir73il@gmail.com,
 linux-nfs@vger.kernel.org, anand.jain@oracle.com,
 linux-unionfs@vger.kernel.org, linux-xfs@vger.kernel.org,
 linux-fsdevel@vger.kernel.org, linux-btrfs@vger.kernel.org, jack@suse.com,
 fdmanana@suse.com, ceph-devel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, ocfs2-devel@oss.oracle.com
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 2023/4/5 1:14, Zorro Lang wrote:
> +F2FS
> +L:	linux-f2fs-devel@lists.sourceforge.net
> +S:	Supported
> +F:	tests/f2fs/
> +F:	common/f2fs

Acked-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
