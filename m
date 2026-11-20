Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 62737606A6D6
	for <linux-f2fs-devel@archiver.kernel.org>; Fri, 20 Nov 2026 19:22:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=lists.sourceforge.net header.i=@lists.sourceforge.net header.a=rsa-sha256 header.s=beta header.b=XYW6Tl8u;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sourceforge.net header.i=@sourceforge.net header.a=rsa-sha256 header.s=x header.b=IEsblO7J;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=sf.net header.i=@sf.net header.a=rsa-sha256 header.s=x header.b=U5l621Jd;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=pps01 header.b=e5UKBOwG;
	dkim=neutral header.d=columbia.edu header.i=@columbia.edu header.a=rsa-sha256 header.s=lionmail header.b=0UsMZ9QN
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:To:In-Reply-To:References:Message-Id:MIME-Version:Date:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Unsubscribe-Post:List-Owner;
	bh=sXoJqEiBXHca7Az1cm89Sqk34GKg3e2QEVdBOsMlSns=; b=XYW6Tl8uyJX9HarPSGgjzpiEEg
	vthQpu0kIEN0QUm6ikKyPC6CVKoVi/APT+JJ55IKpgIFWt++3YJwGfJCEcudZR25fXfPEPV+0QhOI
	USkfBKc5LwF0eQwsmIheTP7m5loNCYtwGfuMbspz+ShwWP3eD38WJn6Peqb2X7BGIETI=;
Received: from [127.0.0.1] (helo=sfs-ml-4.v29.lw.sourceforge.com)
	by sfs-ml-4.v29.lw.sourceforge.com with esmtp (Exim 4.100.1)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1xUUCC-000000004aI-26VY;
	Fri, 20 Nov 2026 19:22:52 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-4.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.100.1)
 (envelope-from <tz2294@columbia.edu>) id 1xUUCB-000000004aA-3MCO
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:51 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Cc:To:In-Reply-To:References:Message-Id:
 Content-Transfer-Encoding:Content-Type:MIME-Version:Subject:Date:From:Sender:
 Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
 :Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Unsubscribe-Post:List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WN2nypYKoNw5kBQBrzUyxtnvE/mglzChe44wW4Tw0a8=; b=IEsblO7JaAJK7++euulhHR0ufY
 7Klx/JU/ryAHEjW9U1KBiZPZsEWJhFuq9sGHeJCxDxpYehqiRoodOuPwPHJMspyDQLS/ffc2AX34Q
 5zsugqf1jpvCOkJ1lVsJaDNz75JELWrffwHisQiypcEX97xUmPIrnpqEw44/LO0uvWMo=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Cc:To:In-Reply-To:References:Message-Id:Content-Transfer-Encoding:
 Content-Type:MIME-Version:Subject:Date:From:Sender:Reply-To:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Unsubscribe-Post:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=WN2nypYKoNw5kBQBrzUyxtnvE/mglzChe44wW4Tw0a8=; b=U5l621JdEhXEoPdQjCpnTUOR6g
 7DYDBYk5w6+zxioFHAJrtL42KnxOhAXIo610uZH8XxxasySienWxMtw91gvKWGmPDH0HXJp9+gWMs
 sweh6OqRTcdfGynggL2d4noNh0B69GSW83q9WmJ4nbM1X9+P0hoNfPlZOc7Nd10hOM6o=;
Received: from mx0b-00364e01.pphosted.com ([148.163.139.74])
 by sfi-mx-1.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES256-GCM-SHA384:256) (Exim 4.100.1)
 id 1xUUCB-000000007CO-0LvU
 for linux-f2fs-devel@lists.sourceforge.net;
 Fri, 20 Nov 2026 19:22:51 +0000
Received: from pps.filterd (m0167074.ppops.net [127.0.0.1])
 by mx0b-00364e01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6AKIuo5x3664517
 for <linux-f2fs-devel@lists.sourceforge.net>; Fri, 20 Nov 2026 14:22:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=columbia.edu; h=
 cc:content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=pps01; bh=WN2n
 ypYKoNw5kBQBrzUyxtnvE/mglzChe44wW4Tw0a8=; b=e5UKBOwGEi4/n2TnztwI
 mWaPFIrtjP65iAR7MfyeOAyfWGeWmEEHopmZbDxPoWG/XORJd8NR0qc/rbsfiaYy
 EpPZoDa7UKU1mceimmGwb3/Wkl6acKeRwtRVkc4WzNYanX1TsmrrwtF5wLeH+F8V
 64qgmvS9YqsXv3TpOOezTGUDX6z0dngtwqnrDlecXBTeivMTdX9BGe093FC1jfcC
 mHslcKGSkZtsA2CPikYJSN9k73bEjdImBwpUA6DEMoCmN9CYvmF6FwuyHwmkmJtx
 2b81TwbDnUJXOdLGScUTL3o/7Y+Rtd+gpObOVLGNkP1NQi0HE/xe927tAN7rB0yo
 Nw==
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199])
 by mx0b-00364e01.pphosted.com (PPS) with ESMTPS id 4j2tnu0xer-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 14:22:44 -0500 (EST)
Received: by mail-qk1-f199.google.com with SMTP id
 af79cd13be357-934963b2bc0so265539085a.3
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Fri, 20 Nov 2026 11:22:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=columbia.edu; s=lionmail; t=1795202564; x=1795807364;
 darn=lists.sourceforge.net; 
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=WN2nypYKoNw5kBQBrzUyxtnvE/mglzChe44wW4Tw0a8=;
 b=0UsMZ9QNlIKH8+Zt4XegXbZds1iqNCWFtPaywg3J1/QQY3b6Ven6suHoYnshiQJ6Sm
 xAkHIeP34BBBLE4x3Ao8VXZYBteT05BoxcXAzWygxaUEQf6oKvXLURTeicgoLc5bgOOI
 uun69JzrJf+Hzk9NkXkHVyE7PbzXPal50FUGFNWACZFG3jkf74XH+S8IFLi6HC7pqeor
 Ta8tDHBhHmgkV4ZgFgGypyIQakJdfU0de78kS/2ZzCFOrPwLO/hZyCjW9Iwj/4kP2fOL
 atM08vLrJTllshXDFNpFHS6HtjZs5RO+t5+sTXxJL27THjRyCFh0tgKf8UXn3UqjXcAz
 Sqhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1795202564; x=1795807364;
 h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
 :content-type:mime-version:subject:date:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=WN2nypYKoNw5kBQBrzUyxtnvE/mglzChe44wW4Tw0a8=;
 b=Uf8L0zLaPTps327lvhJBwFbsWclYQd/jh8l+dYFBHQScxOte1CmAepPFpTJfL5Jjn4
 mAl7K+FsgNlyYUZEbpfG3gik57ytILnGQdakYjhX4+aAO+/FLEUoIEpvh521ZZqUj/hQ
 qzyNAWa7gO9mDuH+wkTBMwIVBWMmT2fvaHPOfczaTIlBACtmv45Qe0kYm6IyBrH1L/Zp
 JXUglibf/nUYth0EhKj57klfMtMcKvcBofHBlS+2pTyxXDMQ8i6Y739ssVxWXPcBw9Eg
 4lGh51IH6DjVpGkW0IZ6+yaqSpZKNCjGmZjmXULA5vz/vQ9JueNsCJwlJQvM70Qv2uWM
 AGhA==
X-Forwarded-Encrypted: i=1;
 AL+hErGCny4SX5uBlaBCWzf8r/I55vAp+RECJ7dodJtCQNzRGaMxrv5rYmyaDhNOHpHwTlN4MoUubnsFfuBRnatjyRSr@lists.sourceforge.net
X-Gm-Message-State: APuU4Z87gok1IvB8+Ay3laCFYxbTpQrp15V5fnDOQhtUwgOQ5OGzc69Q
 CI2QSFJJGGBRqLIlZkr+rrBvGS4FNECV8DyNLqeK0ArB9MMfm33PJsXel4+/SwuV5XcM0/Vyw56
 8uqodR8TeWR6VRe9VWbNP3lxjft3VCAE5w2DbstbWu2PBjnAZzUYC0h6a+ZJ97ZkkQsUR5+eioC
 hm7YynbS4=
X-Gm-Gg: AYBFou2MmXaaMUgo6D61xMKEJa2hhFM+50rnXAvv0w0GRLpcVJOBFcYYN+lTtNU+Gs6
 VsPnm38+rVgndbYYrO0/BU/jY6dwWsifsNGkaD4I7s2DrHygs0NmJwITW2E/f3wK1KFDHuyMRNM
 shLvNn809LBNAWcGFJ7WyB3a5YP/Lnfju1YzZfN37Ibbynadf61Qk8sfs4+hhJ57i6FL/VI9bqh
 Z5lfPre9UxdjXfjJ8O0ClTY9ZzJnLzs5hgPK6LPh8GIBqMgZzS2+SHtG83crZS3gOfgBiqVUBQ3
 eLk9dpxW2lVkxapRqBIk4q5zG0mfi8ZjUpSO4lRUehrhxV2a5TLGQJLJH6+RPWvaRyD47W/Wr+A
 r01Nu/QPvjMq8Y8dhjfmisw/vf0YtF/Nxz/KeLXNYTJ4u1CAHBw/xNeRpMpRBcP4eXtGkhNgMXy
 oYY7VnoRKmRVsQU40hw++F
X-Received: by 2002:a05:620a:4142:b0:949:3c50:135 with SMTP id
 af79cd13be357-949baa13071mr647647385a.38.1795202564441; 
 Fri, 20 Nov 2026 11:22:44 -0800 (PST)
X-Received: by 2002:a05:620a:4142:b0:949:3c50:135 with SMTP id
 af79cd13be357-949baa13071mr647644285a.38.1795202564014; 
 Fri, 20 Nov 2026 11:22:44 -0800 (PST)
Received: from [127.0.1.1] (nat-128-59-178-217.net.columbia.edu.
 [128.59.178.217]) by smtp.gmail.com with ESMTPSA id
 6a1803df08f44-92134a08552sm33337636d6.34.2026.11.20.11.22.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 20 Nov 2026 11:22:43 -0800 (PST)
From: Tal Zussman <tz2294@columbia.edu>
Date: Fri, 20 Nov 2026 14:22:05 -0500
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Message-Id: <20261120-f2fs-fio-folio-v1-2-c21f94f82279@columbia.edu>
References: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
In-Reply-To: <20261120-f2fs-fio-folio-v1-0-c21f94f82279@columbia.edu>
To: Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>
X-Mailer: b4 0.17-dev
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795202560; l=1080;
 i=tz2294@columbia.edu; s=20250528; h=from:subject:message-id;
 bh=pt/XrrTlZIsN0yVDF2KcQthpb7D5nwgwhT7EI5s4CvM=;
 b=oAZLNTBVamE6pFJvwt0DHeyiMG3BZ+2q4CwN6bNSJQ7WJ1bd7IMETK7mYNdjj6NIwtgS0mIZq
 a/nhafmJxuJAqJf0n6ejYZo/MkfyPZNI9RlfWOdfKqi03rAs89oRKzl
X-Developer-Key: i=tz2294@columbia.edu; a=ed25519;
 pk=BIj5KdACscEOyAC0oIkeZqLB3L94fzBnDccEooxeM5Y=
X-Proofpoint-GUID: eJuthdJKjX-OoGj9xF_7rpyO9-b1GlY_
X-Proofpoint-Spam-Info: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXy1/omVmz4dod
 kOaEl4NI6q6l+FfpC7gpZv7XX98UASCCGascbtJKwUzPqhCXbuWcoElmwVe48IST+FxKAqv9z5j
 KX6bvE47aoCuzmyeLxwbF6eDufDKFLJUmzI+c3KauAqoBqBUmBGv
X-Authority-Analysis: v=2.4 cv=Dt3Da2/+ c=1 sm=1 tr=0 ts=6b009e05 cx=c_pps
 a=HLyN3IcIa5EE8TELMZ618Q==:117 a=lnglQuR7XRqnmjDHco/WZg==:17
 a=IkcTkHD0fZMA:10 a=zJRp6_cAMcgA:10 a=x7bEGLp0ZPQA:10 a=A0y_DWxS2BwA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=Da8U98TiO7q1upZEImrf:22 a=azVShVRs0zEubeQ0wG0L:22
 a=wovEZKpnVIo4Yrz032cA:9 a=QEXdDO2ut3YA:10 a=bTQJ7kPSJx9SKPbeHEYW:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMTIwMDA3NiBTYWx0ZWRfXzI8n1tLw4YUO
 6rWQ+PDbZS5wjinK0nNjqdO6tLX3jRXTMp2mgzHg8U4weTzQ1tgQX6tyZNb9pvPteUFoG2zpSLy
 qZg6uMR9u08FMESCiGSY7azs7aHVpAR4lvhzfRIdRLKFmYjqwCsbZNB6WukGF4FR4zkCmAJ/c+3
 ULLBznNdx70ImaB8UpO+Bp/tEhHZ5Bhvb87zkli5ElJWjhvFDVY3rdFnMzPrBKFJF9v459cn0jX
 F+6pr/OFhT5b5X2kkXkmi8V7U57YXjfJLOVeMmWmEolu2xjQromjSMt9lESxnOijEderRM17t2y
 +lzyiK3asXmdB1qAZhKvUaCTv6mSegiHyuu8qtg55EM0CO8jGRz4exJ+kqaDjxILGBLVXnyyVTO
 DPUQUrKuSGkByPKo0czxD/DZe++uYaZxULsFe0dk4g1cYT6RYGXDCpO0HIichsBrdkgmqmSzHfr
 zL2cS0UhvwfJxnM4R2g==
X-Proofpoint-ORIG-GUID: eJuthdJKjX-OoGj9xF_7rpyO9-b1GlY_
X-Proofpoint-Virus-Version: vendor=nai engine=6900 definitions=11972
 signatures=596817
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1011 priorityscore=1501 suspectscore=0 lowpriorityscore=10
 spamscore=0 phishscore=0 bulkscore=10 impostorscore=10 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2611040001
 definitions=main-2611200076
X-Spam-Score: -0.2 (/)
X-Headers-End: 1xUUCB-000000007CO-0LvU
Subject: [f2fs-dev] [PATCH 02/28] f2fs: add compressed_folio to struct
 f2fs_io_info
X-BeenThere: linux-f2fs-devel@lists.sourceforge.net
X-Mailman-Version: 2.1.21
Precedence: list
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>, 
 <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: Tal Zussman <tz2294@columbia.edu>,
 "Matthew Wilcox \(Oracle\)" <willy@infradead.org>,
 linux-f2fs-devel@lists.sourceforge.net
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-16.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_PASS,
	SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Make fio->compressed_page a union with a compressed_folio member, so the
users can be converted one at a time. The compressed pages come from the
compression mempool and are always order-0, so the page and folio
pointers are the same.

Signed-off-by: Tal Zussman <tz2294@columbia.edu>
---
 fs/f2fs/f2fs.h | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 6ec1da5d1c43..c365e8715108 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -1353,7 +1353,10 @@ struct f2fs_io_info {
 	struct folio *folio;	/* folio to be written */
 	pgoff_t folio_offset;	/* offset in large folio */
 	unsigned int folio_blkcnt;	/* block count in large folio */
-	struct page *compressed_page;	/* compressed page */
+	union {
+		struct page *compressed_page;	/* compressed page */
+		struct folio *compressed_folio;
+	};
 	struct list_head list;		/* serialize IOs */
 	unsigned int compr_blocks;	/* # of compressed block addresses */
 	unsigned int need_lock:8;	/* indicate we need to lock cp_rwsem */

-- 
2.39.5



_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
