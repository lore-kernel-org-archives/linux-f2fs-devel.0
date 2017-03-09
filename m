From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/2] f2fs: don't need to invalidate wrong
 node page
Date: Thu, 9 Mar 2017 19:36:22 +0800
Message-ID: <29a94fb3-67be-d326-b8f8-a553b18ee549@huawei.com>
References: <20170306215102.3807-1-jaegeuk@kernel.org>
	<8fa2118d-1da0-29f6-a755-fd661333d05d@huawei.com>
	<20170308213546.GB5483@jaegeuk.local>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <linux-f2fs-devel-bounces@lists.sourceforge.net>
Received: from sog-mx-1.v43.ch3.sourceforge.com ([172.29.43.191]
	helo=mx.sourceforge.net)
	by sfs-ml-2.v29.ch3.sourceforge.com with esmtp (Exim 4.76)
	(envelope-from <yuchao0@huawei.com>) id 1clwOL-0002cA-TM
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 11:37:57 +0000
Received: from [45.249.212.189] (helo=dggrg03-dlp.huawei.com)
	by sog-mx-1.v43.ch3.sourceforge.com with esmtps (TLSv1:RC4-SHA:128)
	(Exim 4.76) id 1clwOK-0003Mi-50
	for linux-f2fs-devel@lists.sourceforge.net;
	Thu, 09 Mar 2017 11:37:57 +0000
In-Reply-To: <20170308213546.GB5483@jaegeuk.local>
List-Id: <linux-f2fs-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=linux-f2fs-devel>
List-Post: <mailto:linux-f2fs-devel@lists.sourceforge.net>
List-Help: <mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/linux-f2fs-devel>,
	<mailto:linux-f2fs-devel-request@lists.sourceforge.net?subject=subscribe>
Errors-To: linux-f2fs-devel-bounces@lists.sourceforge.net
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net

On 2017/3/9 5:35, Jaegeuk Kim wrote:
> On 03/08, Chao Yu wrote:
>> On 2017/3/7 5:51, Jaegeuk Kim wrote:
>>> If f2fs_new_inode() is failed, the bad inode will invalidate 0'th node page
>>> during f2fs_evict_inode(), which doesn't need to do.
>>
>> Hmm...should not allow other using of inode->i_ino in following codes of
>> f2fs_evict_inode, right?
> 
> Right.

I mean those codes below invalidate_mapping_pages(NODE_MAPPING(sbi),,)
After having a look at them, I think it's OK without any change. :)

Reviewed-by: Chao Yu <yuchao0@huawei.com>

Thanks,


------------------------------------------------------------------------------
Announcing the Oxford Dictionaries API! The API offers world-renowned
dictionary content that is easy and intuitive to access. Sign up for an
account today to start using our lexical data to power your apps and
projects. Get started today and enter our developer competition.
http://sdm.link/oxford
