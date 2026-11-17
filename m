Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EED2B606A323
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=g18dOGFh;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=Ma5wloO1;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=MzCxC/w2;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cwf0E2uX
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=olcizAOPVQlcftZmXofqeSQeh0jPYhZ6EMCPhOsqqAU=; b=g18dOGFhdhBiqK
	fMbUajDh4COvbImuFZfJzePK75cmNK1q6mWjX/Vj78JzX5g1ioHdofs9UBFAvE3ULaVTPYh0xJdkZ
	be6Fr9prrZi/eeqgwg8dKV744nuYIObBvYFMoGvVHRz19HOiJrK3lxk9fKpvORhmA5jiDb1ZXMRgn
	Ihk=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTHYw-000000007Gb-2tlc;
	Tue, 17 Nov 2026 11:41:22 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTHYv-000000007GT-0wzn
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:41:21 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TxsdMg7m2TDwJDxiSdvyBueM4da+4N/m2t3StX1N6E=; b=Ma5wloO1sdzrSMeifwDAzRV2A+
 BLDhP89BuqP0hKTnk7PP2I8pzJ1pXhEIvE6ACOuv1hWfJNBlf1/cO6bu6poMf8xFyKCMvlEwKIRPA
 XBcg9rZcGao3ljuCfAkt50t8VY8kijikLLnuc3Sg1v1K042X1whXCtZqEH5L2ZvRgir0=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=4TxsdMg7m2TDwJDxiSdvyBueM4da+4N/m2t3StX1N6E=; b=MzCxC/w2P6cZ6WRrMYaSB9O/pz
 wynxWZ7kbeIokkSIzLBb9xoR4Q44WZDVi+NQwEPP0JGbVw3fwpPxZGT9sSVrYgVY7IKR0ZZgjl7bi
 HLWvfi6GeXetzK9BZLl3w3yOrB1X2FzWPb3CYE1aI2/fBgCQeqrDAvNzLdCDYbvF4i/c=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTHYr-000000003mS-1umR
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:41:21 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 2C9F640781;
 Tue, 17 Nov 2026 11:41:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D6B1F000C4;
 Tue, 17 Nov 2026 11:41:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794915672;
 bh=4TxsdMg7m2TDwJDxiSdvyBueM4da+4N/m2t3StX1N6E=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=cwf0E2uXEt0MCoR5AHTisCfgPzrWdjOp/vFC4WYnn8qwhCC2tRzmxsakEbrVXUwFV
 PTWgs+AlFsFXBsugKeRdCOl8FxWL8VVx01LCGIF8eG8rHP2QPsqc43QSJtan/8omPi
 KF35b8sHhBiTOmB5V6i9BZbcxU8QI/5PHkw0Oq7I5E3JOzz0u5mWI955JCtlwfpnNH
 Da3B3wr/NmoChZemsvpAl2gGo/fvM2EBdxI0kJYuGSt+3ZsxhtbEx+exA6bcTWeJwb
 Y52ByWF/8mLuxMqgbqC92Zvd4kp1hNId6caG9RFWQTwQKPtp/1IZkndbIIrA/dPo0P
 1ZE2M8bFFg7gQ==
Message-ID: <21efc4a5-41a9-40b3-a9f8-ab847beb74fb@kernel.org>
Date: Tue, 17 Nov 2026 19:41:09 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-18-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-18-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTHYr-000000003mS-1umR
Subject: Re: [f2fs-dev] [PATCH v2 17/20] f2fs: support subpage blocks in
 online resize
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
> Resize works in blocks, segments and sections, independent of
> PAGE_SIZE, so remove the -EOPNOTSUPP check.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
