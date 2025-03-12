Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B149C282EC
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 12 Mar 2025 02:54:41 +0000 (UTC)
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1tsCEz-0007dY-KA;
	Wed, 12 Mar 2025 02:54:41 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <chao@kernel.org>) id 1tsCEy-0007dS-Fw
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 02:54:39 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=XVZadpX/dQCOE42JU3HXWPeT4M4l3qF3HN3UW7WJXOc=; b=fiJezqv+Y4v/Qwfpixx7f3ZU5g
 9lhna9cQoaHkWQMYsWecOwDiXVHSe43BG9j7qQdnSh/WE2tHfnef/KT9v5Ndlkxv/vSxzLsCbDQkf
 ymhda1YKtz2CNRWjKKNCJguopusWLjni879d2tz7aRQCHloI0LKPfnKOYpPQyvWOfzSk=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=XVZadpX/dQCOE42JU3HXWPeT4M4l3qF3HN3UW7WJXOc=; b=J7p82y9LqjhVyr5e6Gawx8IOV3
 VrcwZMv7R+72ec1DxZIlSRqndzAfm1C6dSH10x/kPnAZDFbX1/QuiM4Ab5T8mAU59MOaMA7RgfrYK
 y3/mx7SpEVHKRfHVx5el+EtuYYBRfeQ8OnSgvMxmyfbTxjVQAPOUzYVP/MCV+xnIOaA8=;
Received: from dfw.source.kernel.org ([139.178.84.217])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.95)
 id 1tsCEx-0000cS-9g for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 12 Mar 2025 02:54:39 +0000
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by dfw.source.kernel.org (Postfix) with ESMTP id 226A65C05F5;
 Wed, 12 Mar 2025 02:52:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90456C4CEE9;
 Wed, 12 Mar 2025 02:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1741748073;
 bh=C1zbuBXEjPXDkQGYrWnhCkc6BhzSl5brBdE9d3HvPg4=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To:From;
 b=iOE3iAEyuE//HbpmHalqj9Qs4fc5U9Y5izRO+82REQtzWLzP9rZSteQsNfeuRWNUW
 IFBUfnHf+ZLYzKvszlcJkOSxjiVWCrH8BWV8c4d6bym0Tof2vRH1NXVj3SFkWy/Vls
 1TJwndG2ElLF90W3+8DIxmjtbbWK77IV67RlaLIAPeDxfBRTJMh2JvMBah5KD+hX4V
 /QXsQVfL9oW+T+UYc7Z40B92OnTOengjAdnn8/dpW10Pian1sPgaPFKqwCPz3vSmhZ
 zQKyJU085GFwZ4qcqA0NifH5ozU9EQdHEqvk1plw8M0f9wbtlVafGaZ75EOo+MBZ+4
 4I7Wvw5Rtobfg==
Message-ID: <7f435c3d-8956-47ef-b2dd-3221b182d907@kernel.org>
Date: Wed, 12 Mar 2025 10:54:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Eric Sandeen <sandeen@redhat.com>, linux-f2fs-devel@lists.sourceforge.net
References: <20250303172127.298602-1-sandeen@redhat.com>
 <20250303172127.298602-3-sandeen@redhat.com>
Content-Language: en-US
In-Reply-To: <20250303172127.298602-3-sandeen@redhat.com>
X-Headers-End: 1tsCEx-0000cS-9g
Subject: Re: [f2fs-dev] [PATCH 2/9] f2fs: consolidate unsupported option
 handling errors
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
Cc: jaegeuk@kernel.org, lihongbo22@huawei.com
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

On 3/4/25 01:12, Eric Sandeen wrote:
> When certain build-time options are disabled, some mount options are not
> accepted. For quota and compression, all related options are dismissed
> with a single error message. For xattr, acl, and fault injection, each
> option is handled individually. In addition, inline_xattr_size was missed
> when CONFIG_F2FS_FS_XATTR was disabled.
> 
> Collapse xattr, acl, and fault injection errors into a single string, for
> simplicity, and handle the missing inline_xattr_size case.
> 
> Signed-off-by: Eric Sandeen <sandeen@redhat.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
