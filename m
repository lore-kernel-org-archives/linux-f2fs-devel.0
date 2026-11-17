Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBEF6606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 08:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=HvVAfDU5;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=CsDDtYWZ;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=QWj/JyzA;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=es9T6PVy
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=d22g6Q3wI91JZwfmVz3Nv1I7dMM1nysAtCqdxPYFbls=; b=HvVAfDU5qKIebj
	Zs1/C0mEeNvgjGnDaZYRu2Fpkzs5A15zYsAgHI2qVPJGgv/xmhVTRBlaX6Kj86yuGsK/4hYdIRaUL
	CQ5dECGrZOWRK27JyZNELf+UIKXtOYTVCp1kzkgtYkDbGyj2FLdKLnGVYFN+Y998TfSGl2XJZ8eON
	fi4=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTEwk-000000007KJ-2Sxt;
	Tue, 17 Nov 2026 08:53:46 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTEwi-000000007K1-37Qx
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:53:44 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MftBNpktnSoHTLOmINdSqknygeCyoEnFPuRaamj6H9s=; b=CsDDtYWZz5Z4UF+bA4YUXIpgiP
 GZANLflDkuG3wmBJLv7Sw4pJ4wbCml82+oZozaCqFKykD6euZ2qtugMcxVcRls5RynIIpnRZdqJAE
 eI5Z/OFKXEB1IW9TQv9ZT0VnT7ebd57wm2SgslUSo7gW8SnGSCO4AlgBx6pu1ttwirdU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=MftBNpktnSoHTLOmINdSqknygeCyoEnFPuRaamj6H9s=; b=QWj/JyzAhlSJLanwmhbFvx0Wc6
 iVoY4h/PUqg2bWSE/sEJVl9WBp0SI195RWPB0DZH6JEyfKghRpY9ZIuaMzkUvUyZguvByZEivjgHq
 T9tgMotsK20mwt+IxtgLpvBT81J73WgqVa9sTSlNwSgSJOE3TOWVGPtxtxS6XdKTU1E0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTEwh-000000002hL-1JEI
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 08:53:44 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 973D061260;
 Tue, 17 Nov 2026 08:53:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4546B1F000C4;
 Tue, 17 Nov 2026 08:53:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794905617;
 bh=MftBNpktnSoHTLOmINdSqknygeCyoEnFPuRaamj6H9s=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=es9T6PVyNsMXDbdKe5FRNjGteCT4yL3FV1PWNol64kqfvd0ndnTIn4z82MSOeklP5
 xackAc4xEhKgvmC6Dk93GDbCX05IiPntQgHhfX+Ou/ddEo4a4s11k8GSl6qnfJE7+K
 9FvS2oqY0UGx6TD5I+VggDMhQfp8xw3PawjnTe+7qp97qG/GauGaIzxlByVXBfaDZb
 vdqQBIAO6HsDxQy8ier0QnudxUWKA/HQFgSYi9Yhga/XBwj4WCJ3bFyZEeXhPHhyYJ
 VrHec/UW70UwMqw2J2FuMTgYrjH8YS/l8KNw7U3gzEYsuJaCKM0Je1DTDkZxyE7CXo
 ynrkl2IRed/uw==
Message-ID: <98904a3a-4a34-4e87-8e17-df1a5d385c35@kernel.org>
Date: Tue, 17 Nov 2026 16:53:34 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-2-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-2-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTEwh-000000002hL-1JEI
Subject: Re: [f2fs-dev] [PATCH v2 01/20] f2fs: use block-based index and
 size calculations in more paths
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
> Several paths still convert between file offsets and block indices with
> PAGE_SHIFT or PAGE_SIZE, assuming that a page holds exactly one
> filesystem block. Use the F2FS_BLK_* helpers there so that they stay
> correct when the block size is smaller than PAGE_SIZE.
> 
> No functional change when the block size equals PAGE_SIZE, except on
> 32-bit architectures: __complete_revoke_list() now computes the
> truncation offset and __clone_blkaddrs() the new i_size in 64 bits, so
> that they no longer overflow beyond 4GB.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
