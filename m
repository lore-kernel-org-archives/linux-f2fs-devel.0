Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67BD7606A32A
	for <linux-f2fs-devel@archiver.kernel.org>; Thu, 12 Nov 2026 10:36:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=LthzWehm;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=XNbhn4b3;
	dkim=fail reason="signature verification failed" (1024-bit key, unprotected) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=OC9SWy/r;
	dkim=neutral header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=FHpHxLEo
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:Message-ID:Date:From:In-Reply-To:References:MIME-Version:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=7Da2c0t9Oxvlo6rU4Fw8WGLzGYWP871FZPeV/04NqBs=; b=LthzWehmJHmUvYznQcoijW//Or
	90jjCqNbMd4zQH8CnVshAtZLJv7SvsyeoTMMIjef8AsoWhGZM7yxkLWqZwy62oxW9+ZcqBWyMUKXi
	/GziWOtZdoD9ml2qgM40AyfwICSrJ9wiYPjkVSX1m4nP+7nzcoUPOnfEjKQWbWJ3qZjc=;
Received: from [127.0.0.1] (helo=sfs-ml-1.v29.lw.sourceforge.com)
	by sfs-ml-1.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xRSAP-000000001IW-1PYH;
	Thu, 12 Nov 2026 10:36:29 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-1.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <jsjlee1020@gmail.com>) id 1xRSAL-000000001GR-3kx5
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 10:36:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Type:Cc:To:Subject:Message-ID:Date:From:
 In-Reply-To:References:MIME-Version:Sender:Reply-To:Content-Transfer-Encoding
 :Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8Jfz/ddD1SYFlgT+G+O9OvMpjqgt/EDuLVrSss95/g=; b=XNbhn4b3DPtp0MHLCp6I+8up1S
 Qd+TQOUZLlHSMVPgXxsgIu8hhjnaxhixPrspzbQwqsE1RExzCZaskTN9t9sjBXeg3WipPG2qlMfTq
 dmA3aHh0A2iYE6wZ1KLJTgqimlhLWRjziaMJQXccz6KsMiqaVg7vUa5XvyOU/RQ0kLxU=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Type:Cc:To:Subject:Message-ID:Date:From:In-Reply-To:References:
 MIME-Version:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=q8Jfz/ddD1SYFlgT+G+O9OvMpjqgt/EDuLVrSss95/g=; b=OC9SWy/rrtfQvjqmWICKgbyjuc
 jnr5P0yr8MTMjX2RfvZBT58MM8dukkqcm/O6U6H7lLMjI/PjEOXQVgC8uvrW+VW82vx4eRfG7m+FQ
 JuGcechBzLHVFBb+w0K0Z+ehRodsVQ11fyl/oKzw3Ae6A6Z//iC+rQejjoObr1IypDbw=;
Received: from mail-yx1-f49.google.com ([74.125.224.49])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.100.1)
 id 1xRSAJ-000000005cu-1Wc8
 for linux-f2fs-devel@lists.sourceforge.net;
 Thu, 12 Nov 2026 10:36:25 +0000
Received: by mail-yx1-f49.google.com with SMTP id
 956f58d0204a3-67c2c2ac1c3so6047648d50.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Thu, 12 Nov 2026 02:36:23 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; t=1794479777; cv=none;
 d=google.com; s=arc-20260327;
 b=PfEYOFnVj7hcvp2jggU5fHVjwlNlnuvWjYI5FymTHKDGV2my70ZheXHyxeGYRAz2Nl
 Tqu9r/yFpRdngQ7pSc1Ivy57e9O+JZ7xuMYg0he/5UwG5N0DqLy/fnvZg5QnDDeObQ3s
 r0Gf9KoSyLrab7qmnjVxkvhK3g6vAnKdBFvGvDhELqhUxf7oLSProPk65nxgoMcLIyMC
 3v4mUjSHjRz/QwIayAh0MYxOWHFpyoLMUDELWAG8UTynoJXiMN1ssAWEJgYLfTGgx14B
 jLZ2T5MqOG1ZnvhFYlWLL9vQVauyksPmJAdaUxxAZA2pLDz556JSdDy/se9tpKUWVU7h
 UKUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com;
 s=arc-20260327; 
 h=cc:to:subject:message-id:date:from:in-reply-to:references
 :mime-version:dkim-signature;
 bh=q8Jfz/ddD1SYFlgT+G+O9OvMpjqgt/EDuLVrSss95/g=;
 fh=QM8zDv/fhhRAFvniBCix4jg9lf2/iGYq1C2rAHw2paE=;
 b=TF+YHUUE9NrLAtX1HfLsmrhyNqAwtZXO5qOYqSQgs10i9+POPUrI0YeYtcdvWsoi/g
 14J/hm7qS0L6zfxDkTgne3ER9OcYx/X8p0LvkzmZHD24wWk6DtGsid5VgAYn/WsMolZo
 X6qAo9+U2FNHXQXhba3tY++4aAAti/cJiaBgNSSgCaCjOCo8cVk7inu0JeLAoRD+QVqu
 tZARl8xgtaDPYAFolpUBuSbTE0nipZEvo8OHAewWskGw5Q4Zo/Z5+Pyz8oSiRRZdYaky
 /QTyF0/l6VXx7K5QczrFGsF1YJhvlU8PJ+P3OOMhHGOcZ31sEokooJUMfQCzl7gllD2s
 cL4g==; darn=lists.sourceforge.net
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1794479777; x=1795084577; darn=lists.sourceforge.net;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=q8Jfz/ddD1SYFlgT+G+O9OvMpjqgt/EDuLVrSss95/g=;
 b=FHpHxLEouNMsbxTB9k4JNWRGG2/Mz61HmZT7Lnywho4NrqteHBhdrLPa0SxREwAwid
 yNKSKf7qChOs6jxbd9PChZUV2XFQ/PUwO4bipefzdsifLf3mBRhBhzE/cr/qA5y0rQgW
 AkdnQkeYhMpw9dqY+f3v2hKSsojHA3czlku40D+lwbJzRqmpGTwWCRAXn816PL+Z2xW0
 d1oANkhLbA/6Q0ppTyPc+8pvjFZXf+a9BjMopAjrR2uQtew8yavDb2laLQlZNZ13YdBu
 5DDGsq75SfvDwL8LCRSai9wEGHA9tn+NDv31axkxTVvZtVeI6DJAX5FA0FjZ2XHoB3JO
 9qEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794479777; x=1795084577;
 h=content-type:cc:to:subject:message-id:date:from:in-reply-to
 :references:mime-version:x-gm-gg:x-gm-message-state:from:to:cc
 :subject:date:message-id:reply-to:content-type;
 bh=q8Jfz/ddD1SYFlgT+G+O9OvMpjqgt/EDuLVrSss95/g=;
 b=ATf68NaRNTgQ6s3LYUtX2+Gv9duBv5W5zaomSnifp7P6ucuWlVoaz5PdS/3xArazsG
 nkf6HbCpKRffrISMJtA33kL9u71DCSQfw27e2ZPvyECz+ABVPcpn4FtgyqSTUT+/QmGT
 Fur1eMeu8wFXMHDCJs3j7/tsZopQDNxu5ByezTT6GwJQ2PUtko+yx8B8rAfCVZPIDbBW
 a3RmYLX7tLmTensCOXqp9YTFCGfYeF4A7kR5rVSkTkB3/ngj5YKGk1deERwgIBhCVZJL
 9HiBalEUdVfzfw0KRXupcQyMtBYQmiLby8ELSADktaWCuqSGuqHgtrTKUmQlYxJUKrJg
 4KIQ==
X-Forwarded-Encrypted: i=1;
 AL+hErFcYksjXIdJotuWMUmJi9mVXiwM23H1WcSy7QM4Fs8BV4Wg4cQgNhOvxe3INbDsj/5NiTGF3D3DNXzuyn2YNtZT@lists.sourceforge.net
X-Gm-Message-State: APuU4Z+VAIeGzt7aqE07o2tKHBpG62jadhnB1SwhckQByPKw+Fvw63wq
 e11bwpp4pNPWWeJ8mzI1OSYIGQDHHTk2RaGn7m+sy1Y14IAAaA+IB4JfTI1stdOroxN3UaHWBLp
 uwqMd2CtkyWXae9ZrXT3u4HAN0kZatsk=
X-Gm-Gg: AYBFou1R3i9X83LngbjUo1CtlGISXAuyn6rGd2EY2UcdQ/B6/mqu1aMLqTTR+KdLwht
 cGPf8nbsX7TQsofz78eLalawhwpmDH34BKHvXn9WP7ND0vt3DUIqDKKoTnJ5wQd6owuIXDKYB2X
 6pJX4jnvYvquhz9e92C39U3CX5NwKuCKp7UNKj67zCd2TNLDgnU0V63b3XG8C/9ZkoEdKjPBu5O
 54T7xrjD6OsozCyIdmYaT2Q/WmEE1txypnAlgcfTn4p4/pXiQm3keQFnsv/NgL2IgfZqhy8PWfo
 g4YiC2ZX+AL2Lkyx/e8NC69wld924YBwoF5pxVzMpxvxUOe/P8Ubto3KskJJz56hKHOawvYeqb4
 cNBUrxwjVS5FG0c7SM590DI3/JcUzALBoMuK72g==
X-Received: by 2002:a05:690e:16a1:b0:67c:2421:f2b2 with SMTP id
 956f58d0204a3-67c67c92edamr4061527d50.6.1794479777495; Thu, 12 Nov 2026
 02:36:17 -0800 (PST)
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
References: <20261004061007.7433-1-jsjlee1020@gmail.com>
 <f3f5fe2c-f0f5-4c23-a2f7-6cb5e09ced5a@kernel.org>
 <CAPHXVrzaWHYccYe+PWLeAf_N3md8ens0UsW7aH-047KGhM4BUg@mail.gmail.com>
 <102da404-ab62-4ba6-b46a-1846ca64c72b@kernel.org>
 <CAPHXVry2O-AYxTvGdzu+m6b3Q=ho=xL0kpWWqCn0vjj-gOe0ZQ@mail.gmail.com>
 <0e156b8a-2876-4bbe-b16c-55c70b3201b3@kernel.org>
In-Reply-To: <0e156b8a-2876-4bbe-b16c-55c70b3201b3@kernel.org>
From: Seongjae Jeong <jsjlee1020@gmail.com>
Date: Thu, 12 Nov 2026 19:36:05 +0900
X-Gm-Features: AclHuK_U1Zhy7LuQUoOjDMhB6pf8bp-c3uFcEEp6iWNjkxPJQT3FnxQehFW7JdY
Message-ID: <CAPHXVrxHvXChxiBxCcHWLaFwvatnDVhSu7wdvPWiBDYaUSOQJg@mail.gmail.com>
To: Chao Yu <chao@kernel.org>
X-Spam-Score: 0.1 (/)
X-Headers-End: 1xRSAJ-000000005cu-1Wc8
Subject: Re: [f2fs-dev] [PATCH] f2fs: skip further SIT updates for already
 invalidated blocks
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: jaegeuk@kernel.org, yi.sun@unisoc.com, linux-kernel@vger.kernel.org,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,
	FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

> I don't see how commit a66cdd985532 ("f2fs: introduce discard_map for f2fs_trim_fs")
> introduce the bug? from the timeline, at that point there is no error handling in
> update_sit_entries() if sit bitmap is inconsistent, right?
>

Hi Chao,

Commit a66cdd985532 added the following two lines:

   if (!f2fs_test_and_clear_bit(offset, se->cur_valid_map))
       f2fs_bug_on(sbi, 1);
+ if (f2fs_test_and_clear_bit(offset, se->discard_map))
+     sbi->discard_blks++;

Even if the cur_valid_map bit was already clear, the added code
could still clear the discard bit and increment discard_blks if the
discard bit was set.

Since my patch skips that update for an already invalidated block,
I thought a66cdd985532 was an appropriate Fixes tag for the discard
bitmap part of the change.

Thanks,
Seongjae


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
