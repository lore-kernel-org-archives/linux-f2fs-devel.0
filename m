Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C3F5606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:13:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=VIIfAqnw;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=NKmCjRee;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=W+O8k8rC;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Ny1o4Eas
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=jGfyNNVwtInie6ekGXfz30sixff/NBhIdcCKHUz8wGE=; b=VIIfAqnwZq4ZaI
	OKHa4d+L0TwIoETijie81OysxseIBSnqx6j1T+bTSDvRF+eWOFWkeCx7+DaXNzXN9VmzlZVxY3Y3i
	yeQ7nL0HEc/bSDppcP7gVNRnyVVtJNKQFXgqov/l5AI8vnwwYSAlcUwHUpBt/DUuk1hDejWZyyg+8
	MZ0=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTH87-000000006TM-3AB0;
	Tue, 17 Nov 2026 11:13:39 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTH86-000000006TG-3OCw
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:13:38 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FRSk+4PvV3kogM9DF8OzMfZDrCAV6XIsCQnNkDxuFog=; b=NKmCjRee7Adrg2LtJ1U88WTpmB
 d5p4GsqbEUJkYo8AoazQQq1QWE/JJbIxXLRcHrVC10Cc6SEgaoGlBF3alTHOIpkUEYdHuZI2laT2P
 wu2IMzLHuRH5O/p9wBa6RwIVS93B+JX2jtYnSqvdyc1MD8V1UZ0rFH6R4HijCPXngNCY=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=FRSk+4PvV3kogM9DF8OzMfZDrCAV6XIsCQnNkDxuFog=; b=W+O8k8rCHlnMqPln9sJ0usxkDY
 okdc+FXy356fG8unWy0xgAcqqkpV8U3+TilRERRAaihPWizaXe7sv8B1HxOu4aQ9834ZQ3pE/4wMS
 BsAXjzv9xvZQprXUUUwa2330KevG10qkr0jLqPJSdozi7NNoVy+J9Fppxwjf0ISKoPA8=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTH85-00000000363-0ndA
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:13:38 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8955062838;
 Tue, 17 Nov 2026 11:13:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 52F831F000C6;
 Tue, 17 Nov 2026 11:13:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794914011;
 bh=FRSk+4PvV3kogM9DF8OzMfZDrCAV6XIsCQnNkDxuFog=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=Ny1o4EasfAJh1BRBm6cDi+tPU2v5g3Son7G+0D1OBwc4rB2lQSUAN7JfvDVmjnIwo
 EXQt7L5y+wBDtodezij1FKUONwbV7l34IZGMSrn7t1uOFHxtD3X3nzZ+aK/7AigwgT
 vArreDGysB7GChuWlQPk2HHiUBW2buN7PvtZQjwh0Y4YwSBlk96ntqqYY5AlEw2wZv
 SsU5JP3OgRC33kJClGWKRMu4GpDxFhXJ0atBxnkcMtD8Tdnaq5iVALTD6vkCqpOpoS
 4jWPlo433o91JAWYA0NIesui7+36I7lOSXacDVL7b88s5s+IWRTKw3J5rJNQUuIe8e
 +NZR4CULgPO8A==
Message-ID: <9f4992e5-5d48-456c-ae4f-e14160774045@kernel.org>
Date: Tue, 17 Nov 2026 19:13:28 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-11-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-11-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTH85-00000000363-0ndA
Subject: Re: [f2fs-dev] [PATCH v2 10/20] f2fs: support subpage blocks in
 collapse and insert range
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
> The folio holding offset may hold blocks before the shifted range.
> Write back the page cache from the PAGE_SIZE boundary below offset
> under invalidate_lock before truncating it from there, so that no
> data is lost. Detect src and dst in the same folio by folio index
> instead of block index, as a folio holds several blocks. Remove the
> -EOPNOTSUPP check.
> 
> Also take i_gc_rwsem[WRITE] and invalidate_lock before that writeback
> and keep them until the moved blocks are written back and the page
> cache is dropped, as move range does. After the block exchange, the
> page cache holds the old data of the source blocks until then. With
> subpage blocks, page_mkwrite dirties every block of a folio up to EOF,
> so a store to a neighbouring block in between writes the old data back,
> over a hole or over the moved data. This also keeps GC away from the
> inode until then, for any block size.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
