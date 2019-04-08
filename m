From: Chao Yu <yuchao0@huawei.com>
Subject: Re: [PATCH 1/5] f2fs: clean up codes with op_is_write()
Date: Mon, 8 Apr 2019 19:13:41 +0800
Message-ID: <d43af776-dc5e-24d0-dd48-3e74aca43943@huawei.com>
References: <20190402105222.28374-1-yuchao0@huawei.com>
 <20190405163137.GC51212@jaegeuk-macbookpro.roam.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="windows-1252"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190405163137.GC51212@jaegeuk-macbookpro.roam.corp.google.com>
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
To: Jaegeuk Kim <jaegeuk@kernel.org>
Cc: linux-f2fs-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org, chao@kernel.org
List-Id: linux-f2fs-devel.lists.sourceforge.net

On 2019/4/6 0:31, Jaegeuk Kim wrote:
> On 04/02, Chao Yu wrote:
>> This patch uses generic function op_is_write() to instead private defined
>> macro is_read_io() for cleanup.
> 
> I don't see huge reason to clean up this, but do expect huge backporting issue.

Got it.

Thanks,
