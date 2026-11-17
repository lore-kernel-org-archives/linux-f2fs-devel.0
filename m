Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CE59606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:54:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=IRqbkS93;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MN7yPiKN;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=PMRP7b25;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jWcplbQU
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=yUI9V1zVN+cBafxnjUDHZbwXSnkGPDmEgq18o/ASw/Q=; b=IRqbkS9376AwGM
	nwYST6W09wPeNk/blzSAKSxHMA63i192KjXaE3eZ0fTblYxxMx06z9/CRP16mCf2mWT3L3r2j4mvM
	1drF/eptYZ8NrUTS/0EW8G6XkwbXk9RstfTQiyxvqDSuza3j3KmxJsQ4gO2T0gXO+QzuIwEqjyKwz
	OqY=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTExs-000000000E1-0hRY;
	Tue, 17 Nov 2026 08:54:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTExq-000000000DN-3gS6
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:54 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxdLiFwyc8Gq60+I63AKVENYnHNqRL/u4NGrOjiglIg=; b=MN7yPiKN5Sdf4ZTLjIug2jDJT+
 yQB53wM53iunJmFBH8ri0CkVwdgPHibap/Uj6fnxbWaNKzEyVTPaW7Zefrc5afMgzRs0B6nUbpMRC
 fVqxmlVoUdrO1QmG+Z889vTNqCeFwRokHoGlZosaYd9oQmXIqwH0OCyAsXTRVb1hG3ow=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=vxdLiFwyc8Gq60+I63AKVENYnHNqRL/u4NGrOjiglIg=; b=PMRP7b2537pjWIZn20N3MA+9tT
 bbvQM/RUUZKZPxm0twFQU70OkQIfMtQSjKFjX6cS7NAyb0ubrSbROnj8vAT6YPcMWKL1unilX/q1H
 C4OaYX2/lGEfiSfNRe1qpLiV8jydneLAH3xyAVA6uT2NuFlaCs+M4wmeiyyTBztTwJUM=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTExq-000000006kp-22M9
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:54:54 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E19A43B2C;
 Tue, 17 Nov 2026 08:54:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 053511F000C4;
 Tue, 17 Nov 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905689;
 bh=vxdLiFwyc8Gq60+I63AKVENYnHNqRL/u4NGrOjiglIg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=jWcplbQUGYXrrjDlyJCjObuv0TgOqBMact6wNqHDMporBfYd84WfVYgSXdUNXbpYQ
 4JRp1zFFE4cjV1MSU3UcMqlfuqOdyg6Ehco5ddifykcvi/6vcIqxIm/DL+fUOm/Awh
 LttYHokqH8cZ0XO2kqnZjTqs7d5WNxEqwlX3ayYyaUGVZJOmSydCGUz/EzRcQ94FL7
 qcX7y2RysznTTfmNvd055slPQLngZ7NC9jowYr+I1dpesUCSjG0c/vLmDHjLU+tcwS
 72PM1eVR4+yhi3TDDJ9Hd13ZAiNfESeij/Rv5QX+lCoqIseRVd5X1LFFyeY64vJ3R2
 te6oC8WBBhjng==
Message-ID: <fe0a193f-6225-4e9a-b831-1d7a806d8d55@kernel.org>
Date: Tue, 17 Nov 2026 16:54:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-6-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-6-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTExq-000000006kp-22M9
Subject: Re: [f2fs-dev] [PATCH v2 05/20] f2fs: convert inode dirty page
 counters to dirty block counters
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
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
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 11/16/26 12:08, Daeho Jeong wrote:
> From: Daeho Jeong <daehojeong@google.com>
> 
> The per-inode dirty counter is compared against block based thresholds
> such as min_fsync_blocks and BLKS_PER_SEG, and it already holds blocks:
> its helpers take page counts and convert them. Rename it to
> dirty_blocks and make the helpers take block counts, and convert to
> pages where a counter is compared with page based values. The
> conversions are no-ops when the block size equals PAGE_SIZE.
> 
> The callers that account one block for a folio are left as they are,
> which is still correct when the block size equals PAGE_SIZE. Later
> patches convert them.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
