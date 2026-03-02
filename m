Return-Path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.sourceforge.net (lists.sourceforge.net [216.105.38.7])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 08F6ED58E49
	for <linux-f2fs-devel@archiver.kernel.org>; Mon,  2 Mar 2026 03:41:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.sourceforge.net; s=beta; h=Content-Transfer-Encoding:Content-Type:Cc:
	List-Subscribe:List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:
	Subject:MIME-Version:References:In-Reply-To:Message-Id:Date:To:From:Sender:
	Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender
	:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=xTY3DCQq/I4hpO+br1wUeqnUI7EZBaFhSrQCLe1RpXA=; b=RkbNK2+r1ktbT/0Nqgj1obJuf5
	91tA1n0cdRPYLbWmngiCG9LQPMAFbAcZai+vXqIIMB3UDrBS3LABFDvpRaoj38zvzaXi5n6wQiOx2
	G5xc9uv+vVVb3r0ztAK9z19/YcxKjvXCaaMcxiXZJIKsic6NffXWyAKu8rJUmz+voqTA=;
Received: from [127.0.0.1] (helo=sfs-ml-3.v29.lw.sourceforge.com)
	by sfs-ml-3.v29.lw.sourceforge.com with esmtp (Exim 4.95)
	(envelope-from <linux-f2fs-devel-bounces@lists.sourceforge.net>)
	id 1vwu9o-0006FS-0g;
	Mon, 02 Mar 2026 03:41:20 +0000
Received: from [172.30.29.66] (helo=mx.sourceforge.net)
 by sfs-ml-3.v29.lw.sourceforge.com with esmtps (TLS1.2) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.95)
 (envelope-from <wangqing7171@gmail.com>) id 1vwu9m-0006FK-GY
 for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 03:41:18 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=sourceforge.net; s=x; h=Content-Transfer-Encoding:MIME-Version:References:
 In-Reply-To:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
 Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
 Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
 List-Subscribe:List-Post:List-Owner:List-Archive;
 bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=; b=Z3MXEuYaLjOgoZ0IawuzdcZcTL
 X3umS9pDlR0JNbKLRI019wLwvDuoDS2JbLpcvxmvO5t6uzL9ioIx3QB9y7Y3tW7iLsG6K75DFSHRJ
 azxq6k8ZtBYOPoehGulVlFi18WnAq1IHZIUS6v/KiwTQiYs0fqxerAdA5y52BAsxHkaI=;
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=sf.net; s=x
 ;
 h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
 Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
 :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=; b=QDqFUgKlmhQFLY9VfKkHxd/0fD
 73WH0OCcF4jbcKzY+GoaKmhRVEfrcHLtX0NFzXFDF4fgTWtCowkn6ozWbjq7Kor1TpLAp3L1CaZDJ
 vZNU/BQSougfQoQ4iBYfBsbAK49q1GrwpvlW/Dx4Ksi0ah9paeP8EXFJqZE96vJ4Po3Y=;
Received: from mail-pf1-f194.google.com ([209.85.210.194])
 by sfi-mx-2.v28.lw.sourceforge.com with esmtps
 (TLS1.2:ECDHE-RSA-AES128-GCM-SHA256:128) (Exim 4.95)
 id 1vwu9m-0003SR-6u for linux-f2fs-devel@lists.sourceforge.net;
 Mon, 02 Mar 2026 03:41:18 +0000
Received: by mail-pf1-f194.google.com with SMTP id
 d2e1a72fcca58-82742aa5a3eso1738262b3a.1
 for <linux-f2fs-devel@lists.sourceforge.net>;
 Sun, 01 Mar 2026 19:41:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20230601; t=1772422872; x=1773027672; darn=lists.sourceforge.net;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=;
 b=U2nYyF2im6D+Q7aN1fmV4K8pYityshhUTHzXBs88xVC8uZuSt+MCiB9oiWMdYTpGqP
 yL0Xh7WWHjjiyTxVrOW0Z5PJVUrQDi/LdbozECIEkXopeWMYgLDHgCSSy41SIvB7Qc9g
 rItyFhBa6WlwNIGAmFc2YX8oTlHW24w4CzuF+hdpoirKPAqrUZtkTIxeW3DcjZWMSlKT
 j/yGyjbpII2uBQO4OJ8gXOl11c8uv5vkiyFCnodgI6jFCfYmmPEv1woDW4tv5uuhTtfF
 cxoBFMgip6iChMaWw+eX/S1TrJrTU6SzclwOXZxsfGhqvgnHv2avZlmVpYoPLtIDm745
 7pHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20230601; t=1772422872; x=1773027672;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VnRkT2AhttnAXKxBGtLqNZYa9ovtnVLLt5dqgljoP2A=;
 b=cuRzqzGqDufWa2i7oREzhgE+CZHyezks2fezsx//YRuX+eWxtPuIO0CvNhf+tnAlcM
 7tL6/hnNGTUFZEa9ivDdvSECZ4iPq+mTiBjJ+Behak/LaUYswOpkQYrfT8nKWqPPdgIJ
 3vbrbQRhJvtCEdp+lKt0Ju9QoZFZ3TVjeAgFakCrPAy/OkLw0pVl2T5HjHMPZEM2Sz6/
 YM5uBjZHq8Fseo+FgElcOvpvb4m11Nh6D8VwLHE5Ja4BbNhlMcOCLRjrWzZwhT+EMKpN
 6JIj6IOiWD1EsOSm3CASPnrn3/nylHWl1mWSGl48JytUA7hgOcdbrND/vCbVgcdQgfGx
 xMfA==
X-Forwarded-Encrypted: i=1;
 AJvYcCW0jpa9GX0UrnjxGyGnZr/mQQIXcLjJsw6ClEl9ZUm1CtIq7uRnwrjEND9rIjD8EjjNl2jZsbzMkMcF4kYk216g@lists.sourceforge.net
X-Gm-Message-State: AOJu0YxCvTjA5/0Q2WjUScds+DZFuckH7wqzFkIBXaHY9Nx1TXYINfmZ
 WPMutLr/tRfDQqI6QNY7+IcNHayuXsfwQIOP2gcqPj4tCIYNw3y4a3b8
X-Gm-Gg: ATEYQzzHQZL1GCx2n5D98eJJ8UI4jTyf68DGMZhewzI7aZgrwNe3KKrMH2VQqYDcPo1
 /z2fHeH5lbzCcrSgRj/oIkx2CdXTKyyS98fxX7OLGvx+/tUvfhWQEN5NBh/N8bEexvfO74BkAoL
 HZEyO4xYXU/KC/DV2moeIn8+v52zt7S8gIfCeIe/hd898lCwXDi8uGdi5qRVTw7woEsC5AZAPBX
 6bsbobo+cO0Gskrx5YMBiLYQYfK4tj9iwWb8a7bjZytX4VS9tnC/CY4ZY9RquXHoNoNUgKZtEsj
 oQOUN/W6OO577RDa4ubQmHH7M9iS99Hgajli4TOn3HmME5qTkIv0OUvy1+yp13ZfwQIFvSgGD53
 qIalUm00Upx/2wd6ey2ON5z13yskoNF5IilRusfo/Qo+V7S1HNbO29NG+1npNWiGmgeob+CbbpR
 h9+y9dH702JbL99JcVNnVl6Zo4TC2TVx9WlmAt4/Az4H8zkwVoQQ==
X-Received: by 2002:a05:6a00:f85:b0:81f:852b:a936 with SMTP id
 d2e1a72fcca58-8274d9530b8mr11492201b3a.15.1772422872419; 
 Sun, 01 Mar 2026 19:41:12 -0800 (PST)
Received: from lima-ubuntu.hz.ali.com ([47.246.98.208])
 by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-82739ff34fesm10838369b3a.42.2026.03.01.19.41.06
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 01 Mar 2026 19:41:11 -0800 (PST)
From: Qing Wang <wangqing7171@gmail.com>
To: syzbot+cae7809e9dc1459e4e63@syzkaller.appspotmail.com
Date: Mon,  2 Mar 2026 11:41:02 +0800
Message-Id: <20260302034102.3145719-1-wangqing7171@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
References: <698a26d3.050a0220.3b3015.007e.GAE@google.com>
MIME-Version: 1.0
X-Headers-End: 1vwu9m-0003SR-6u
Subject: Re: [f2fs-dev] [syzbot] [mm?] [f2fs?] [exfat?] memory leak in
 __kfree_rcu_sheaf
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
Cc: lorenzo.stoakes@oracle.com, jannh@google.com,
 syzkaller-bugs@googlegroups.com, linux-kernel@vger.kernel.org,
 Liam.Howlett@oracle.com, linux-f2fs-devel@lists.sourceforge.net,
 linux-mm@kvack.org, pfalcato@suse.de, linux-fsdevel@vger.kernel.org,
 jaegeuk@kernel.org, akpm@linux-foundation.org, sj1557.seo@samsung.com,
 linkinjeon@kernel.org, vbabka@suse.cz
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net

#syz test

diff --git a/mm/slub.c b/mm/slub.c
index cdc1e652ec52..387979b89120 100644
--- a/mm/slub.c
+++ b/mm/slub.c
@@ -6307,15 +6307,21 @@ bool __kfree_rcu_sheaf(struct kmem_cache *s, void *obj)
 			goto fail;
 
 		if (!local_trylock(&s->cpu_sheaves->lock)) {
-			barn_put_empty_sheaf(barn, empty);
+			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
+				barn_put_empty_sheaf(barn, empty);
+			else
+				free_empty_sheaf(s, empty);
 			goto fail;
 		}
 
 		pcs = this_cpu_ptr(s->cpu_sheaves);
 
-		if (unlikely(pcs->rcu_free))
-			barn_put_empty_sheaf(barn, empty);
-		else
+		if (unlikely(pcs->rcu_free)) {
+			if (barn && data_race(barn->nr_empty) < MAX_EMPTY_SHEAVES)
+				barn_put_empty_sheaf(barn, empty);
+			else
+				free_empty_sheaf(s, empty);
+		} else
 			pcs->rcu_free = empty;
 	}
 


_______________________________________________
Linux-f2fs-devel mailing list
Linux-f2fs-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel
