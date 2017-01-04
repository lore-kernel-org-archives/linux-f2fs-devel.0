From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 07/10] f2fs: don't allow encrypted operations
 without keys
Date: Wed, 4 Jan 2017 16:56:39 +0800
Message-ID: <45891420-122e-4edc-c337-e464a81ed8d8@huawei.com>
References: <20161230185117.3832-1-jaegeuk@kernel.org>
	<20161230185117.3832-7-jaegeuk@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-3.v43.ch3.sourceforge.com ([172.29.43.193]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1cOhWh-0005wf-0k
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 09:06:31 +0000
Received: from szxga01-in.huawei.com ([58.251.152.64])
	by sog-mx-3.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1cOhWc-0008Kv-FL
	for linux-f2fs-devel@lists.sourceforge.net;
	Wed, 04 Jan 2017 09:06:30 +0000
In-Reply-To: <20161230185117.3832-7-jaegeuk@kernel.org>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net
Cc: Theodore Ts'o <tytso@mit.edu>

On 2016/12/31 2:51, Jaegeuk Kim wrote:
> This patch fixes the renaming bug on encrypted filenames, which was pointed by
> 
>  (ext4: don't allow encrypted operations without keys)
> 
> Cc: Theodore Ts'o <tytso@mit.edu>
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <yuchao0@huawei.com>


------------------------------------------------------------------------------
Check out the vibrant tech community on one of the world's most 
engaging tech sites, SlashDot.org! http://sdm.link/slashdot
