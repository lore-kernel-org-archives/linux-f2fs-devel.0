Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8FE1606A320
	for <linux-f2fs-devel@archiver.kernel.org>; Wed, 11 Nov 2026 08:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=bsVBy/Zw;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=MinuDO79;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=CHZOUh0D;
	dkim=neutral header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PXa0ERs0
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	Reply-To:From:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:Subject:In-Reply-To:References:To:MIME-Version:Date:
	Message-ID:Sender:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:
	List-Owner; bh=PtfSdllgU49AXMoNlcyij4vvjU7Nse/3rZKCY5sdUvc=; b=bsVBy/Zw/riRQy
	Fn8i4jRYq0wV0GeN5Q+W8AV2muZdLu4b5lyIJcoD5XHHLcyayWpT6Kreso/QR2p90g3YO4z1hk1Yf
	hWZs79PW5gTP5Bni67TLY2M8MwIDQQJd35YxQ8YVrV9txMNNOeZ51WnguOn12Aml5HbEVwfGOnJOf
	16w=;
Received: from [127.0.0.1] (helo=sfs-ml-2.v29.lw.sourceforge.com)
	by sfs-ml-2.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xR3db-000000002F6-2Nrd;
	Wed, 11 Nov 2026 08:24:59 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-2.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <chao@kernel.org>) id 1xR3da-000000002Ex-2swj
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:24:58 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:
 From:References:To:Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xnCSJW7H9S7oLfU3AFOJs3YKSIztd+0pFsjMncCYbg=; b=MinuDO79WyVFigxH58YAwmSVK6
 mlOw4IigK99HgnUonCDNInhwtWc4hQA/kEEsUOcVegS2p36mY3fWY5A6kSdzrVekmGJ1/0aqygbS9
 Ues0ugGHNCpdiQY9Q5HEiWmT5NJdRVDGuE0VSZ0WR3bHwBsDYPNlXXw/i6ySdTMHE31g=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:References:To:
 Subject:Cc:MIME-Version:Date:Message-ID:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=8xnCSJW7H9S7oLfU3AFOJs3YKSIztd+0pFsjMncCYbg=; b=CHZOUh0DHOh7aYRDgxcDDUaWwo
 0H9c5Y/IFFfEy8EJdYzfg0dQkEliIxWMgU6ca1IXJpEy4KAT38zuyeDX/KGodPu6/96w6ZhD8xqkt
 QiR49+b3brWlJ+LEz21mZ+uGrR2+XW19pN/UKgEO77U3dRasE5TQ8TD6rIZiQUHj2MEc=;
Received: from tor.source.kernel.org ([172.105.4.254])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xR3dZ-0000000079P-0HCT
 for linux-f2fs-devel@lists.sourceforge.net;
 Wed, 11 Nov 2026 08:24:58 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7789461243;
 Wed, 11 Nov 2026 08:24:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81D461F00A05;
 Wed, 11 Nov 2026 08:24:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794385491;
 bh=8xnCSJW7H9S7oLfU3AFOJs3YKSIztd+0pFsjMncCYbg=;
 h=Date:Cc:Subject:To:References:From:In-Reply-To;
 b=PXa0ERs04RKsc9OpBK9UtuQop0juqrhhnmFIVeWSXCvQyerS9qQw+m1SFP/SwSK6J
 QGhJBoOomEQ7YV58erSWybmBM+9idovzz6oF20et84MX13DWDdxU2MqOmVrfRDJIlT
 cpIZP3gJ+n41Z6pqk0W3Di/a0SCj7YYRgNlCNt7dU1ThG1Vsa6OxtY7dbxBjMq07VB
 XSaWmV/uJtjbRztbDyi65Q13GSwm4EAgRLB5oVD9NUd5Q3OrjyGAnb8uFQyFUh5CHS
 t9/dqaVJkDg31tbeZbrZXAF3bvLBB4lkEn8gtQh4LtEklr/vr/4CiBwDy2ka+wK7u4
 arKdXzCqvWzeA==
Message-ID: <233616a7-798e-4229-97e4-0919cc61fc40@kernel.org>
Date: Wed, 11 Nov 2026 16:24:48 +0800
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: Wentao Liang <vulab@iscas.ac.cn>, jaegeuk@kernel.org
References: <20261104030757.1537720-1-vulab@iscas.ac.cn>
Content-Language: en-US
In-Reply-To: <20261104030757.1537720-1-vulab@iscas.ac.cn>
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xR3dZ-0000000079P-0HCT
Subject: Re: [f2fs-dev] [PATCH] f2fs: log the inline-data inode before
 dropping its reference
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
Cc: "linux-f2fs-devel@lists.sourceforge.net"
 <linux-f2fs-devel@lists.sourceforge.net>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INCLUDES_CR_TRAILER,
	MAILING_LIST_MULTI,SPF_HELO_PASS,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

+Cc f2fs mailing list

On 11/4/26 11:07, Wentao Liang wrote:
> gc_data_segment() calls iput() and then formats inode->i_ino into the
> error message.  If that was the last reference, the inode has been
> evicted and the inode number is read from freed memory.
> 
> Move the message ahead of iput() so it is emitted while the inode is
> still pinned.
> 
> Fixes: fc01008c92f4 ("f2fs: fix to do sanity check on F2FS_INLINE_DATA flag in inode during GC")
> Cc: stable@vger.kernel.org
> Assisted-by: DeepSeek-V4.1-Flash and OpenAI Codex
> Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
