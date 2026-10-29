Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22C04606A31C
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 29 Oct 2026 01:31:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=QrLdhyTu;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=bpiqIkjG;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=B8wGlEba;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ad/Zd2li
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=0BirhLtiVpuyX8a5ybfn1+C6VGpY4sAHktXR4MwxERs=; b=QrLdhyTuLd2oIP
	JFdc3Ny2lnoREMcsRqNe1fpTOP4NCUrKQppFlV0bPWpEx0nOT4LDiSwbweP1apugDZ/pkGjI9b7rz
	w3cD1FCmWleasWBSYY78KWhsHPvmwyqUB+iUVxns0mTZTP3fcf1wtCFPxoBIsfmz2H59aY8rAYI6/
	nII=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xMEzl-000000004iZ-3bqw;
	Thu, 29 Oct 2026 01:31:57 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xMEzk-000000004iQ-32eu
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:56 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=35RtJRrcug9GhWpJmIM7ZP68rxkvgihcbPPiLAkaQ8Y=; b=bpiqIkjGyNIgL0MB7E3PuDkx56
 /3ieivPVN2ogEi68WVHqF/5A77IiWxVSdpMqeRk5R2AK5PwlvobZuTQbJeii+pSUaPhZjH+ScfkLL
 XJ/n2D90ewZGQYpmlVphBy5JIZ/vwEa3MtOKEVGT0sOTc6Fafh8bNNa0XCx2/A3Q2Gq4=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=35RtJRrcug9GhWpJmIM7ZP68rxkvgihcbPPiLAkaQ8Y=; b=B8wGlEba8JgLkCXpu1XzQmL/Ef
 0sErFbDQ2H6qi9GFR4jmyZt9VaTdfnvY3MSRmz1ZiBk6gJrQEh20HhvV0hqYFA/vrscbgbfojeIlx
 rdPpp14tviUs49PxTnVhBX74VHsaXwEjTbW45qKKprwLK2zntUKyVufNEb4EE4GNM1l0=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xMEzk-000000008IU-15I4
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 29 Oct 2026 01:31:56 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id AD39E600D1;
 Thu, 29 Oct 2026 01:31:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C60551F01825;
 Thu, 29 Oct 2026 01:31:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793237510;
 bh=35RtJRrcug9GhWpJmIM7ZP68rxkvgihcbPPiLAkaQ8Y=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=ad/Zd2liOx+7lIQwJfkevl890cKDoL0oJdZoYxQI9dvmVpXcsXfss3QylRJ1Pm3rv
 E4m3uGrXKoCXrbhb4LBHw1+fQpsCP45/EjamTc2Rtu8G9LolOrlApI9AgKQ81Wd5Ul
 lOaMqtKCtkRowns4q+OfnLzKzJhFYc8TfPtEAxhATM0U2gyVkDqNcwkjQu19HhFiLf
 mUdgcI6+xxX85p7j7kwQnyTnGdb0wP5eUVEs99VwnaduU4QV079osUd5MtL3QQTgU5
 7DEEzz0zTmIUuO6O7WGrjSEa3P092pO7xFrw7TDjazV7KHYPLUgqqn48qwXnCnglAS
 gM9rdScqFn+DA==
Message-ID: <6c9275d8-6819-4758-a36b-28c3256134ae@kernel.org>
Date: Thu, 29 Oct 2026 09:31:46 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Nanzhe Zhao <nzzhao.sigma@gmail.com>,
 linux-f2fs-devel@lists.sourceforge.net, Jaegeuk Kim <jaegeuk@kernel.org>
References: <20261028154407.1601430-1-nzzhao.sigma@gmail.com>
 <20261028154407.1601430-5-nzzhao.sigma@gmail.com>
Content-Language: en-US
In-Reply-To: <20261028154407.1601430-5-nzzhao.sigma@gmail.com>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xMEzk-000000008IU-15I4
Subject: Re: [f2fs-dev] [PATCH v8 04/15] f2fs: support atomic file large
 folios buffered write
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
Cc: Barry Song <baohua@kernel.org>, Juan Yescas <jyescas@google.com>,
 Daeho Jeong <daehojeong@google.com>, linux-kernel@vger.kernel.org,
 Dev Jain <Dev.Jain@arm.com>, David Hildenbrand <David.Hildenbrand@arm.com>,
 Pengfei Li <lipengfei28@xiaomi.com>, Bo Zhang <zhangbo56@xiaomi.com>,
 Kalesh Singh <kaleshsingh@google.com>, Nanzhe Zhao <nzzhao@126.com>,
 Nanzhe Zhao <zhaonanzhe@xiaomi.com>, Ryan Roberts <Ryan.Roberts@arm.com>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

On 10/28/26 23:43, Nanzhe Zhao wrote:
> From: Nanzhe Zhao <zhaonanzhe@xiaomi.com>
> 
> ioctl can convert an inode with large folio support into an atomic
> file. Support large folio buffered writes for atomic files as well.
> 
> Add a large folio atomic write_begin helper that reserves COW mappings
> for the write range. For partial head and tail subpages, read the
> existing data from either the COW inode or the original inode before
> marking the subpage uptodate.
> 
> Signed-off-by: Nanzhe Zhao <zhaonanzhe@xiaomi.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
