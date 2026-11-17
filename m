Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FCC0606A88A
	for <linux-f2fs-devel@archiver.kernel.org>; Tue, 17 Nov 2026 11:09:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=iNQ5TJiW;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MxqUeQK9;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=NB/gGA94;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=immzbok0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=CDWgeMCAck7ZBAny+OC7xnV0jAALKgJJoVnH+6Gj1Js=; b=iNQ5TJiWqIwPMa
	By1onOxTY+q5FrLHUE2pU/gUjt96A6xo/M8Xb6qvVi+J5kyo80MF1AoZIjjBOgIKMEz36wlHO00Ux
	9UmuDDtm0UOSIvXVxmtsQ6uE/R2vLI5n0W4NRWMfC2GOIMrxTXTqw5ixnLmsycboiSbXGfH21FaB9
	6Ik=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xTH4W-000000006Tq-2dop;
	Tue, 17 Nov 2026 11:09:56 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xTH4V-000000006Ti-0JGD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:09:55 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jjy8BGHOPaGtQ/OXipxmCbCq3eIN0qjXNTsf9LR2DNk=; b=MxqUeQK9/uz+L0s00OuW2SAiV5
 qNwSoO22ARKaW+oc4aESD8U3rnL3aSZeWsFmZdXud6AhSsVTI/6WMX2r+rHm6+QeaVxOfolgti1LF
 cTEWekssT//VZH4XvOof5cprHGewcYHsDpMtAdXAeod0hLvoUMEASzj2Cl9HZxWkYZGQ=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=Jjy8BGHOPaGtQ/OXipxmCbCq3eIN0qjXNTsf9LR2DNk=; b=NB/gGA94kY72vodERa4xl8hkSv
 Vi2go7kHBzD68d6IiH+8vYGUwnShUJi8UQx5RTvkEnLaFQOi6IdvyD0G4dVZQWzcnxip4MzRYcK60
 0GKeH8xE1cFKsHmN6VRoelZUyfWKpZUDjo0IuPJ4lFjw7+ordSjju1OePIKTfEGGM7zo=;
Received: from sea.source.kernel.org ([172.234.252.31])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xTH4T-0000000030Q-1ruD
 for linux-f2fs-devel@lists.sourceforge.net;
 Tue, 17 Nov 2026 11:09:55 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1FAA342D81;
 Tue, 17 Nov 2026 11:09:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA1131F000C4;
 Tue, 17 Nov 2026 11:09:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794913788;
 bh=Jjy8BGHOPaGtQ/OXipxmCbCq3eIN0qjXNTsf9LR2DNk=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=immzbok0sAivMG0BdoT2MWaBHG/7aSAjc+P9xQZWXZ6sFtrXwG5Pp1sTOiwWUDRN+
 ANGMYRnmJ0tWBP/kG91VhITt2zB5euhTdakRs8RkOozylAk2aWrVT8nhd76MV3SarB
 776QLG2The9xgmKYfn184SF8iOww6SozZ/TFUAaeN3c7dcMZGFcJfcKk8tj1g1IU8I
 aJt3fhvP5ukv2fakv6U1gAck6H+0usPJZHcyBXzhHpPfQ2XnfM6drUj7NNEwVhIwml
 Z9QUqEWjlS5A9GCJk1//Xd+MyJa8Ws0FSfbjmHj0rxDp8UyjDvFN5M5538jGbTTW5Z
 sYnM/w+dia+1Q==
Message-ID: <5757fccb-83ef-4432-9e01-2dffd712bd9a@kernel.org>
Date: Tue, 17 Nov 2026 19:09:45 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Daeho Jeong <daeho43@gmail.com>, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net, kernel-team@android.com
References: <20261116040851.2849696-1-daeho43@gmail.com>
 <20261116040851.2849696-10-daeho43@gmail.com>
Content-Language: en-US
In-Reply-To: <20261116040851.2849696-10-daeho43@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xTH4T-0000000030Q-1ruD
Subject: Re: [f2fs-dev] [PATCH v2 09/20] f2fs: support subpage blocks in
 pinned files
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
> Pinned files must not allocate blocks outside fallocate(). As write()
> does, return -EIO from page_mkwrite when the folio range up to EOF is
> not fully allocated, and remove the -EOPNOTSUPP checks.
> 
> page_mkwrite keeps failing a device aliasing file with -EIO, as it does
> when the block size equals PAGE_SIZE. Its block addresses are only in
> the extent cache, so f2fs_overwrite_io() does not catch it.
> 
> Signed-off-by: Daeho Jeong <daehojeong@google.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
